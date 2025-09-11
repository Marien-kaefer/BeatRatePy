%stack_variance_rolling_abs_diffdestinationUsing pixel variance to extract 'contraction' profiles
%20/03/2025 - code adapted by Marie Held (Image analyst @ Centre for Cell
%Imaging, University of Liverpool, UK)

clear all
close all

%%%%%%%%%  USER SETTINGS  %%%%%%%%%%%%
video_rate=31 %frame rate of the video in fps. Must be an integer. 
exp_beat_rate=0.75 %anticipated beat rate in Hz
offset=fix(0.2 * video_rate/exp_beat_rate) %this sets the size of the difference between the comparison frames (will depend on frame rate). Must be an integer.  
%offset=15 
pixel_calibration = 1.3798 % image calibrations, i.e. how many µm does a pixel dith/height represent. This assumes square pixels.

files = dir('*.tif*');
directory = pwd + "\";

for i=1:length(files)
    
    disp("Processing file " + i + "/" + length(files) + ": " + files(i).name); 
    
    [pathstr,filename_without_extension,ext]=fileparts(files(i).name); %extract file name without extension

    props = dir(files(i).name);
    file_size = props.bytes; 
    disp("File size: " + file_size); 


    output_directory_for_big_tiff = directory + filename_without_extension + "\";
    %disp("Input file size is larger than 4 GB. The output tiff would also be larger than 4 GB, which cannot be exported using Matlab. Therefore, writing individual slices into the following output directory: " + output_directory_for_big_tiff); 
    disp("Creating output directory: " + output_directory_for_big_tiff); 
   
    if ~exist(output_directory_for_big_tiff, 'dir')
        mkdir(output_directory_for_big_tiff); 
    end


    %import time series
    disp("Importing image data");
    TimeSeriesData = tiffreadVolume(files(i).name); 
    TimeSeriesData = uint16(TimeSeriesData); 
    number_of_frames = size(TimeSeriesData,3);
    if offset < number_of_frames
        


        %%%%% First: calculate the rolling Pixel Variance for the data set to get 'speed' %%%%
        disp("Calculating Pixel Variance data");
        for j=1:number_of_frames-offset

            PV_data_stack(:,:,j)=std(double(TimeSeriesData(:,:,j:(j+offset))),0,3);

        end

        %normalisation to 16 bit and write stack
        disp("Normalising Pixel Variance data");
        PV_data_stack=uint16(65535*(PV_data_stack-min(PV_data_stack(:)))./(max(PV_data_stack(:))-min(PV_data_stack(:))));


        for j=1:number_of_frames-offset
            name = output_directory_for_big_tiff + filename_without_extension + '_PixelVariance_' + sprintf('%0.4d',j) + '.tiff';
            imwrite (PV_data_stack(:,:,j),name);

        end


        %%%%% Second: spatially sum images to extract 'speed' traces %%%%
        disp("Calculating Speed"); 
        for j=1:number_of_frames-offset

            speed(j)=mean(mean(PV_data_stack(:,:,j)));

        end

        speed_scaled = speed .* pixel_calibration; 
        speed_normalized = (speed_scaled - min(speed_scaled)) / (max(speed_scaled) - min(speed_scaled));


        %%%% Third: Extract 'key_frame' to compare difference against %%%
        key_frame=find(speed==min(speed));
		disp("Key frame: " + key_frame);


        %%%% Fourth: Calculate local Pixel Variance for current frame and key frame %%%
        sample_window=offset;
        num_frames=size(PV_data_stack,3);
        TimeSeriesData = double(TimeSeriesData); 

        disp("Calculating contraction data"); 


        for i=1:num_frames

            contraction(i)=mean(mean(abs(std(TimeSeriesData(:,:,i:i+sample_window))-std(TimeSeriesData(:,:,key_frame:key_frame+sample_window)))));

        end

        f_contraction=fftshift(fft(contraction));
        filt=hann(length(contraction));
        f_contraction=f_contraction.*filt';
        contraction=real((ifft(fftshift(f_contraction))));
        contraction_scaled = contraction .* pixel_calibration; 

        contraction_normalized = (contraction_scaled - min(contraction_scaled)) / (max(contraction_scaled) - min(contraction_scaled));

        time_series_c=(1/video_rate)*[1:length(contraction)];
        output_c=[time_series_c; contraction; contraction_scaled; contraction_normalized];

        figure(1)
        time_series_c=(1/video_rate)*[1:length(contraction)];
        plot(time_series_c,contraction_scaled)

        title('Contraction')
        xlabel('Time (s)')
        ylabel('Contraction (µm)')

        figure(2)
        time_series_s=(1/video_rate)*[1:length(speed)];
        plot(time_series_s,speed')

        title('Speed')
        xlabel('Time (s)')
        ylabel('Speed (µm/s)')

        figure(3)
        time_series_c=(1/video_rate)*[1:length(contraction)];
        plot(time_series_c,contraction_normalized)

        title('Contraction')
        xlabel('Time (s)')
        ylabel('Contraction (normalized)')

        figure(4)
        time_series_s=(1/video_rate)*[1:length(speed)];
        plot(time_series_c,speed_normalized)

        title('Speed')
        xlabel('Time (s)')
        ylabel('Speed (normalized)')

        %%%% Fifth: export data to directory folder  %%%%

        fileID = fopen([directory + filename_without_extension + '_contraction.txt'],'w');
        fprintf(fileID,'%12s\t %12s\t %12s\t %12s\n','time','contraction','contraction_scaled (µm)', 'contraction (normalised)');
        fprintf(fileID,'%12.2f\t %12.8f\t %12.8f\t %12.8f\n',output_c);
        fclose(fileID);

        time_series_s=(1/video_rate)*[1:length(speed)];
        output_s=[time_series_s; speed; speed_scaled; speed_normalized];

        fileID = fopen([directory + filename_without_extension + '_speed.txt'],'w');
        fprintf(fileID,'%12s\t %12s\t %12s\t %12s\n','time','speed','speed_scaled (µm/s)', 'speed (normalized)');
        fprintf(fileID,'%12.2f\t %12.8f\t %12.8f\t %12.8f\n',output_s);
        fclose(fileID);

        figure(1)
        saveas(gcf,[directory + filename_without_extension + '_contraction_scaled.png'])

        figure(2)
        saveas(gcf,[directory + filename_without_extension + '_speed_scaled.png'])

        figure(3)
        saveas(gcf,[directory + filename_without_extension + '_contraction_normalized.png'])

        figure(4)
        saveas(gcf,[directory + filename_without_extension + '_speed_normalized.png'])
    else
        disp ("Offset is larger than number of frames. Skipping file."); 
    end
    
    clearvars -except directory exp_beat_rate files offset pixel_calibration video_rate
    close all;
end
disp("Done!")

