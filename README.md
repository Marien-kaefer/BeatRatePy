# Cardiac Waveform Analysis of Transmitted Light Time Series Images

## Overview

This repository contains the Matlab/Python code associated with the following publication:
	* **INSERT INFO**

## Getting started

You can modify the Matlab code and/or the Jupyter notebook to run on your own data. In order to do this, you will need to produce some data to analyse or use some of e exemplary data published here **[insert DOI & link]**.

# Jupyter Setup

## Step 1: Download this Github Repository 

Please see the following link for instructions on how to download the repository: 
[https://docs.github.com/en/get-started/start-your-journey/downloading-files-from-github](https://docs.github.com/en/get-started/start-your-journey/downloading-files-from-github)

## Step 2: Install a Python Distribution

We recommend using conda as it is relatively straightforward and makes the management of different Python environments simple. You can install conda from [here](https://www.anaconda.com/download) (miniconda will suffice).

## Step 3: Set Up Environment
Once conda is installed, open Anaconda Prompt and run the following series of commands:

```
conda create --name jupyter-napari-env python=3.11 
conda activate jupyter-napari-env
conda install -c conda-forge napari pyqt -y
pip install jupyterlab matplotlib ipywidgets bioio bioio-czi bioio-ome-tiff bioio-tifffile bioio-bioformats
```

You have successfully set up the necessary conda environment! You do not need to repeat these step unless you require a new environment or you are setting this up on another system. 

## Step 4: Usage

We have found that Jupyter notebooks run well in Google Chrome. 

To start the notebook, open Anaconda prompt and activate your environment, if not yet active, and then launch jupyter notebbok. 

```
conda activate jupyter-napari-env
jupyter lab
```

A browser window will open within which you can navigate to the location of your notebook. Please note that a single click opens folders amd files. 

When finished with any analysis, save the notebook if desired. Go to [File > Close and Shut Down Notebook]. Close the Jypyter browser tab in you web browser. Then go to the Anaconda prompt window and use [Ctrl C] to stop Jupyter, then deactivate the environment you have created with the following command.
```
conda deactivate
```

Close the Anaconda prompt. 

# Video conversion to Tiff sequence
Convert movies from mov to tiff sequence via https://mconverter.eu/convert/mov/tiff/ 
Drag and drop .mov file for conversion. Select .tiff. Download as .zip and extract into a folder or download individual files (much slower). This option will only work for videos that are <100 MB. 

For videos larger than 100MB, use FFMPEG: FFMPEG Installation (please note that you will require admin rights on your PC to change environment variables): https://www.youtube.com/watch?v=OspDzkCKFKE&t=189s 
Once FFMPEG has been installed and verified as described in the youtube video above, use the command line prompt to navigate to the folder containing the images. See here for an post of the command line prompts required to navigate the PC drive and folder structure. 

Overview over an FFMPEG command: ffmpeg [options] [[infile options] -i infile]… {[outfile options] outfile}…

Once in the folder that contains the video(s) type the following command (for more info see here): 
```
ffmpeg -i IMG_3685.mov -pix_fmt rgba IMG_3685_stills_%04d.tif
```

* "IMG_3685.mov" - input file name
* "-pix_fmt rgba" - set pixel format to rgba 
* "IMG_3685_stills_%04d.tif" - output file name and type (tif), the “%04d” specifies the position of the characters representing a sequential number in each file name matched by the pattern. Using the above example the output files will be called IMG_3685_stills_0001.png, IMG_3685_stills _0002.png, IMG_3685_stills _0002.png and so on. For longer videos you will need to use a higher number (%08d.tif). 

The output files will be written into the same directory as the input files unless a different directory is specified in the command above. Press enter to start the conversion. There wil be various parameters of the video displayed and the last line gives an update on the exported frames. Once the conversion has finished, the command line is ready to receive the next command, e.g. to convert the next video. When done, close the command line prompt. 