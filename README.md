# BeatRatePy - Automated Hight-Throughput Python-Based Beat Rate Quantification and Generation of Speed and Contraction Traces

## Overview

This repository contains the Python code associated with the following publication:

* **https://www.biorxiv.org/content/10.64898/2026.10.21.760713v1** 

The Python notebook (`Jupyter_notebook` folder) analyses time-lapse microscopy images of beating cardiac tissue. It extracts quantitative measures of contractile motion, namely **contraction amplitude** and **contraction speed**, as traces over time, estimates the **beat rate**, and saves the results as numerical data files, plots and pixel variance image stacks. It supports analysing a single file or a whole folder of files (batch mode). The originak Matlab version of the code is located in the folder `Matlab` for reference only. Further details are in `Docs/BeatRatePy_Documentation.pdf`.

You can modify the Jupyter notebook to run on your own data. To do this you will need to produce some data to analyse, or use the exemplary data published in BioImage Archive: **[10.6019/S-BIAD4119](https://www.ebi.ac.uk/biostudies/bioimages/studies/S-BIAD4119)**.

## Contents

1. [Quick start (summary)](#quick-start-summary)
2. [New to Jupyter notebooks? Key concepts](#new-to-jupyter-notebooks-key-concepts)
3. [Jupyter setup](#jupyter-setup)
   - [Step 1: Download this GitHub repository](#step-1-download-this-github-repository)
   - [Step 2: Install a Python distribution](#step-2-install-a-python-distribution)
   - [Step 3: Set up the environment](#step-3-set-up-the-environment)
   - [Step 4: Start the notebook](#step-4-start-the-notebook)
4. [Using the notebook](#using-the-notebook)
   - [What you need before you start](#what-you-need-before-you-start)
   - [Running an analysis, step by step](#running-an-analysis-step-by-step)
   - [Parameter reference](#parameter-reference)
   - [Choosing the offset](#choosing-the-offset)
   - [What the analysis does](#what-the-analysis-does)
   - [Beat rate estimation](#beat-rate-estimation)
   - [Output files](#output-files)
   - [Interpreting the results](#interpreting-the-results)
   - [Notes and limitations](#notes-and-limitations)
5. [Closing down](#closing-down)
6. [Preparing your data: video conversion to TIFF sequence](#video-conversion-to-tiff-sequence)
7. [Troubleshooting](#troubleshooting)
8. [Glossary](#glossary)
9. [Licence](#licence)

## Quick start (summary)

If you have done this before, this is the short version. Detailed instructions follow below.

1. Download the repository and unzip it.
2. Install Miniconda (or Anaconda) once.
3. Create the environment once (Step 3).
4. Every time you want to analyse data: open the Anaconda Prompt, run `conda activate jupyter-napari-env`, go to the repository-containing folder with `cd`, run `jupyter lab`, and open the notebook in the `Jupyter_notebook` folder.
5. Run **Code Cell 1**, fill in the parameter form (at least the input folder, file name and video rate) and click **Submit parameters**. Then run **Code Cell 2**.
6. Find the results in the `analysis` subfolder inside your input folder.
7. When finished: save, shut down the notebook, press `Ctrl+C` in the prompt, run `conda deactivate`.

## New to Jupyter notebooks? Key concepts

You do not need any programming experience to run an existing notebook, but the information below might make getting started easier.

**What is a Jupyter notebook?** A notebook (file ending in `.ipynb`) is a document that mixes explanatory text, code and results (plots, tables, images) in one place. It is opened in your web browser, but it runs entirely on your own computer. No data is uploaded anywhere.

**Cells.** A notebook is made of blocks called *cells*. There are two kinds you will meet:

- **Text (Markdown) cells** contain explanations and headings. You only read these.
- **Code cells** contain Python code. You *run* these, one at a time. Results appear directly below the cell.

**Running a cell.** Click on a cell so that it is selected (a coloured bar appears on the left), then press `Shift + Enter`, or click the **Run** (triangle) button in the toolbar. The selection then moves on to the next cell, so repeated `Shift + Enter` steps through the notebook from top to bottom.

**Cell status.** The square brackets to the left of a code cell tell you its state:

| Indicator | Meaning |
|---|---|
| `[ ]` | The cell has not been run yet |
| `[*]` | The cell is running or waiting. Wait until it finishes before running the next cell |
| `[7]` | The cell has finished. The number is the order in which cells were run |

**Run cells in order.** Cells depend on each other. Later cells use results created by earlier cells, so run them **from top to bottom** and do not skip cells. If you get an unexpected error, the most common cause is that a cell above was not run.

**The kernel.** In the background a Python process called the *kernel* remembers everything you have run so far. If something behaves strangely, restart it: menu **Kernel > Restart Kernel and Run All Cells** (or **Restart Kernel** and then run the cells again one by one). A restart does not delete your notebook text or files. It only clears the kernel's memory. When a notebook is busy, the circle at the top right is filled.

**Interactive controls (widgets).** Notebooks can contain tick boxes, text fields, buttons and sliders that appear below a cell. This notebook uses them for its parameter form: you change a value or click a button instead of editing code.

**The napari window.** napari is an image viewer. When the notebook opens an image in napari, it appears as a **separate window** outside the browser. It may open behind the browser window. Check your taskbar (Windows) or Dock (macOS) if you cannot see it. Do not close it while you are still working with the notebook.

**Saving.** The notebook is saved with **File > Save Notebook** (or `Ctrl+S`; `Cmd+S` on macOS). Saving stores the code and visible results in the `.ipynb` file. If you want to keep an untouched original, make a copy first (right-click the file in the file browser > **Duplicate**) and work in the copy.

**Editing code.** For this notebook you do **not** need to edit any code. You change all settings in the parameter form that Cell 1 displays, and Cell 2 (the analysis) must be left unchanged. If you accidentally change something in a cell and the notebook stops working, download the notebook from GitHub again.

## Jupyter setup

You need to do the setup (Steps 1 to 3) only **once** per computer. Step 4 is repeated every time you want to use the notebook.

### Step 1: Download this GitHub repository

On the repository page on GitHub, click the green **Code** button and then **Download ZIP**. Unzip the file to a folder of your choice. This creates a folder called `BeatRatePy-main`, which contains the `Jupyter_notebook` folder.

Tips:

- Choose a location with a short path and, if possible, without spaces or special characters, for example `C:\Analysis\BeatRatePy-main`. Avoid cloud-synchronised folders (OneDrive, Dropbox), which can interfere with reading and writing files.
- Remember the location. You will need it in Step 4.

More detailed instructions for downloading from GitHub are here: <https://docs.github.com/en/get-started/start-your-journey/downloading-files-from-github>

If you are familiar with Git you can instead clone the repository.

### Step 2: Install a Python distribution

We recommend **conda**, because it is relatively straightforward and makes it simple to manage separate Python environments. Download and install it from <https://www.anaconda.com/download>. The smaller *Miniconda* version is sufficient.

Use the default installation options. After installation, you should find **Anaconda Prompt** in the Windows Start menu. On macOS and Linux, use the normal **Terminal** application wherever the instructions below mention the Anaconda Prompt.

**What is the Anaconda Prompt?** It is a text window in which you type commands and confirm them with `Enter`. It might look unfamiliar at first, but you only need to copy and paste the commands given here. To paste in the Windows prompt, right-click or press `Ctrl+V`.

**What is an environment?** An environment is a separate, self-contained set of Python packages. Creating one for this notebook means that the packages needed here do not interfere with anything else installed on your computer.

### Step 3: Set up the environment

Once conda is installed, open the **Anaconda Prompt** and run the following commands. Type or paste each command, press `Enter`, and wait until it has finished (the prompt returns) before entering the next. If you are asked `Proceed ([y]/n)?`, type `y` and press `Enter`. This step downloads several hundred megabytes and can take several minutes.

1. Create a new conda environment to host the notebook:

   ```
   conda create --name jupyter-napari-env python=3.11
   ```

2. Activate the environment that was just created. The text at the start of the prompt line changes from `(base)` to `(jupyter-napari-env)`, which tells you that the environment is active:

   ```
   conda activate jupyter-napari-env
   ```

3. Install napari. Check <https://napari.org/stable/getting_started/installation.html> for the most up-to-date napari installation instructions.

   ```
   conda install -c conda-forge napari pyqt6 -y
   ```

4. In the same environment, install the other packages required to run the notebook (`scipy` is used for the signal processing, `tifffile` for reading and writing TIFF files, and the `bioio` packages for reading CZI and other microscopy formats):

   ```
   pip install jupyterlab matplotlib ipywidgets scipy tifffile bioio bioio-czi bioio-ome-tiff bioio-tifffile bioio-bioformats
   ```

You have now set up the necessary conda environment. You do not need to repeat these steps unless you want a new environment or are setting this up on another computer.

**Optional check.** With the environment active, this command should print `All packages found`:

```
python -c "import napari, bioio, tifffile, scipy, ipywidgets, matplotlib; print('All packages found')"
```

### Step 4: Start the notebook

We have found that Jupyter notebooks run well in **Google Chrome**. If possible, set it as your default browser before you start.

1. Open the **Anaconda Prompt**.
2. Activate the environment, if it is not already active (look for `(jupyter-napari-env)` at the start of the line):

   ```
   conda activate jupyter-napari-env
   ```

3. Go to the folder that contains the repository using the `cd` ("change directory") command. Put the path in quotation marks if it contains spaces.

   Windows, same drive as the prompt:

   ```
   cd "C:\Analysis\BeatRatePy-main"
   ```

   Windows, different drive (for example `D:`). The `/d` is needed to switch drives:

   ```
   cd /d "D:\Analysis\BeatRatePy-main"
   ```

   macOS / Linux:

   ```
   cd ~/Downloads/BeatRatePy-main
   ```

   Tip: in Windows File Explorer, click into the address bar of the repository folder, copy the path, and paste it after `cd /d `.

4. Start JupyterLab:

   ```
   jupyter lab
   ```

A browser window (or tab) opens with the JupyterLab interface. Leave the prompt window open and running. It is the "engine" behind the notebook. If the browser does not open by itself, copy the address that starts with `http://localhost:8888/` from the prompt window into your browser.

**Why `cd` first?** JupyterLab can only show the files in the folder it was started in (and the folders inside it). Starting it from the repository folder lets you see the `Jupyter_notebook` folder in the file browser on the left. Keep this in mind for your data (see "Using the notebook").

## Using the notebook

### What you need before you start

**Your image data.** One or more time-lapse recordings of beating cardiac tissue:

- Supported formats: `.czi` (Zeiss), `.ome.tiff`, `.tif` and `.tiff`. Other formats that Bio-Formats can open may work but have not been tested and are currently not filtered for.
- Each recording must be **one file containing many frames** (a time series). A file with only one frame cannot be analysed.
- Images must be grayscale (single channel), or the channel to analyse must be the **first channel** in the file. If a file has several channels, only the first is used.
- Place all files for an analysis in **one folder**. Sub-folders are not scanned. 
- Files to be processed in batch must have been redcorded with the same frame rate and - if using calibration. 

**Two numbers that you must know for your recording:**

- The **frame rate** (frames per second) at which the time-lapse was recorded. Check your acquisition settings or the image metadata.
- Optional: The **pixel size** (µm per pixel), if you want results in physical units rather than pixels.

> The form in the notebook is pre-filled with placeholder values (video rate 1 fps and pixel size 1 µm/px). If you do not change them, the time axis and the units of your results will be wrong.

**The beat rate** of your tissue is estimated automatically by default. If you know it and want to enter it yourself, have it ready in Hz (beats per second).

### The JupyterLab window

- **Left:** the file browser, showing the repository folder. A **double-click** (in some setups a single click) opens a folder or file.
- **Centre:** the working area. Opened notebooks appear here as tabs.
- **Top of a notebook:** the toolbar with buttons to save, add a cell, cut/copy/paste, run (triangle), stop (square), restart (circular arrow) and run all cells (double triangle).
- **Top right of a notebook:** the name of the kernel (for example `Python 3 (ipykernel)`) and a status circle. If you are asked to select a kernel, choose the Python 3 kernel.

### Running an analysis, step by step

The notebook has **two code cells** only. Cell 1 is a parameter form, and Cell 2 is the analysis.

1. In the file browser, open the folder `Jupyter_notebook` and open the notebook file (ending in `.ipynb`).
2. **Run Cell 1.** Click on the first code cell and press `Shift + Enter`. A graphical form appears below the cell, with tick boxes, text fields and number fields. You might have to scroll down/up to see it. 
3. **Fill in the form.** At a minimum, check or set:
   - **Input directory**: the folder containing your image file(s). Paste the plain folder path (copy it from the File Explorer address bar), without surrounding quotation marks.
   - **File name**: the exact name of your file including the extension, for example `sample_01.czi` (or tick **Process all files in directory** to analyse the whole folder).
   - **Video rate (fps)**
   - **Pixel calibration**, if you want µm units (tick **Calibrate with pixel size** and enter the value).
   - See the [parameter reference](#parameter-reference) for all settings. For a first try, the defaults for everything else are a sensible starting point.
4. **Click the "Submit parameters" button.** The notebook prints a message confirming that the parameters were accepted. **This step is essential**: Cell 2 will not use your settings until you have clicked the button. If you change anything in the form later, click **Submit parameters** again.
5. **Run Cell 2.** Click on the second code cell and press `Shift + Enter`. The analysis starts and prints progress messages below the cell. The `[*]` next to the cell shows that it is still running. Large files take time. Do not modify the code in this cell.
6. In **single-file mode**, napari opens in a separate window at the end of the analysis, showing your original image stack and the pixel variance stack. It may appear behind the browser window. In **batch mode** napari is not opened, so that the processing is not interrupted.
7. When the `[*]` has changed into a number and the output reports that processing is finished, open the `analysis` subfolder (inside your input folder) to find the results. Check the plots, in particular the autocorrelation plot (see [Beat rate estimation](#beat-rate-estimation)).

To analyse another file, go back to Cell 1: change the file name (or other settings) in the form, click **Submit parameters** again, and re-run Cell 2.

### Parameter reference

All settings are entered in the form shown by Cell 1.

| Parameter | Default | Description |
|---|---|---|
| Input directory | A placeholder path | Full path to the folder containing your image file(s). Edit the text field to point to your data folder. |
| Process all files in directory | Unticked | Ticked: every compatible file in the folder is processed one after the other (batch mode). Unticked: only the file named in **File name** is processed. |
| File name | `Example.czi` | Needed only when batch mode is not ticked. The exact file name including the extension, for example `sample_01.czi`. |
| Video rate (fps) | 1 | The frame rate at which the time-lapse was recorded, in frames per second. **Change this to your actual frame rate.** |
| Calculate beat rate | Ticked | Ticked: the beat rate is estimated automatically from the image data (autocorrelation). Unticked: the value in **Manual beat rate** is used. |
| Manual beat rate (Hz) | 1 | Used only when **Calculate beat rate** is unticked. The expected beat frequency of the tissue in Hz (beats per second). |
| Calculate offset | Ticked | Ticked: the offset (window length) is calculated automatically as **Fractional offset x (video rate / beat rate)**. Unticked: the value in **Offset (frames)** is used. |
| Offset (frames) | 15 | The rolling window length, in frames, used to compute the pixel variance. Used only when **Calculate offset** is unticked. |
| Fractional offset | 0.2 | Fraction of one beat period used to set the window length when the offset is calculated automatically. 0.2 means that the window covers 20 % of one beat cycle. |
| Calibrate with pixel size | Unticked | Ticked: speed and contraction results are multiplied by the pixel calibration and given in physical units (µm and µm/s). Unticked: results stay in pixel units. |
| Pixel calibration (µm/px) | 1 | Physical size of one pixel in micrometres. Check your microscope acquisition settings or image metadata. |

Rules of thumb for a first analysis: leave **Calculate beat rate** and **Calculate offset** ticked, set the **frame rate**, and set the **pixel size** if you need physical units.

### Choosing the offset

The offset controls the time window (in frames) over which the variability of each pixel is measured. It should be a fraction of one beat period: long enough to capture meaningful motion, but short enough not to span multiple beats.

With automatic offset calculation and the default fractional offset of 0.2, the window is 20 % of the estimated beat period. For example, tissue beating at 1 Hz recorded at 31 fps gives an offset of approximately 6 frames (0.2 x 31 / 1).

If the contraction trace looks noisy or flat, try adjusting the **Fractional offset**. Values between 0.15 and 0.35 are typical. A larger fraction smooths the trace but may reduce the sensitivity to rapid contractions.

### What the analysis does

Cell 2 performs the following steps for each file. You do not need to understand them to use the notebook, but they help to interpret the results.

| # | Step | Description |
|---|---|---|
| 1 | Load image | Opens the file (`tifffile` for `.tif`/`.tiff`, `bioio` for `.czi` and other formats) and arranges it as Height x Width x Time. |
| 2 | Beat rate estimation | If **Calculate beat rate** is ticked: computes a motion signal from frame-to-frame differences and finds the dominant beat period by autocorrelation. The result is printed and saved. An autocorrelation plot is also saved. |
| 3 | Pixel variance stack | For each frame, computes the standard deviation of each pixel over a rolling window of (offset + 1) frames. Bright values mean fast-changing, i.e. moving, pixels. The stack is scaled to 16 bit and saved as an OME-TIFF. |
| 4 | Speed calculation | Averages the pixel variance over the whole image at each time point, giving a 1D **speed** trace. Slow drift is removed with a baseline correction (10 %-width uniform filter). The trace is scaled by the pixel calibration if selected. |
| 5 | Key frame selection | Finds the frame with the lowest speed. This is the quietest frame (tissue at rest) and is the reference for the contraction calculation. |
| 6 | Contraction calculation | For each frame, compares the pixel-wise standard deviation within the rolling window with that of the key frame. The mean absolute difference over all pixels is the **contraction** value at that time point. The trace is smoothed with a Savitzky-Golay filter (window of about one beat period, polynomial order 3). |
| 7 | Save results | Saves the speed and contraction traces as tab-delimited text files, and as four PNG plots (scaled and normalised versions of both traces). |
| 8 | Save pixel variance stack | Saves the pixel variance stack (padded with empty frames at the start to match the original time axis) as an OME-TIFF that contains the pixel size and time interval. |
| 9 | napari viewer | Single-file mode only: opens the original stack and the pixel variance stack in napari. |
| 10 | Memory clean-up | Frees memory before the next file is processed. |

### Beat rate estimation

When **Calculate beat rate** is ticked, the beat rate is estimated directly from the images:

1. The mean absolute difference between consecutive frames gives a motion signal over time.
2. Slow baseline drift is removed (subtraction of a 10 %-width uniform filter).
3. The signal is smoothed (Savitzky-Golay filter).
4. The autocorrelation of the smoothed, zero-mean signal is computed. The first prominent peak beyond a minimum lag of 0.3 seconds gives the beat period.
5. The beat rate is 1 / period, and is printed in both Hz and BPM (beats per minute).

> **Always check the autocorrelation plot** (`*_autocorrelation_for_beatrate.png`) to verify that the correct peak was chosen. The red dot marks the detected period, and other candidate peaks are orange. If the red dot is on a secondary peak (for example a harmonic), untick **Calculate beat rate**, enter the correct **Manual beat rate** from your experimental records, click **Submit parameters** and re-run Cell 2.

### Output files

All outputs are saved to a subfolder called `analysis`, which is created automatically **inside your input directory**. Files are named after the input image file name (without extension), shown below as `*`.

| Output file | Contents |
|---|---|
| `*_processing_params.txt` | Text record of all parameters used, including the calculated beat rate if automatic detection was enabled. |
| `*_autocorrelation_for_beatrate.png` | Plot of the motion signal over time and the autocorrelation function used to estimate the beat rate. Saved only when **Calculate beat rate** is ticked. |
| `*_contraction.txt` | Tab-delimited table with columns: time (s), contraction in pixels, contraction in µm (if calibrated), contraction normalised. |
| `*_speed.txt` | Tab-delimited table with columns: time (s), speed in pixels/s, speed in µm/s (if calibrated), speed normalised. |
| `*_contraction_scaled.png` | Plot of the contraction over time, in pixels or µm depending on the calibration setting. |
| `*_contraction_normalized.png` | Plot of the contraction normalised to the range 0 to 1. |
| `*_speed_scaled.png` | Plot of the speed over time, in pixels/s or µm/s. |
| `*_speed_normalized.png` | Plot of the speed normalised to the range 0 to 1. |
| `*_PixelVariance.ome.tiff` | Image stack of the pixel variance at each time point, with pixel size and time increment in the metadata. Open it in Fiji or napari. |

Example for an input file `sample_01.czi` in the folder `C:\Data\Experiment1`:

```
C:\Data\Experiment1\
  sample_01.czi
  analysis\
    sample_01_processing_params.txt
    sample_01_autocorrelation_for_beatrate.png
    sample_01_contraction.txt
    sample_01_contraction_scaled.png
    sample_01_contraction_normalized.png
    sample_01_speed.txt
    sample_01_speed_scaled.png
    sample_01_speed_normalized.png
    sample_01_PixelVariance.ome.tiff
```

The `.txt` files are tab-delimited and can be opened in Excel (File > Open, choose "tab" as the delimiter in the import dialog) or in any plotting or statistics software. The `.ome.tiff` file can be opened in Fiji (**File > Open**) or napari.

### Interpreting the results

**Contraction trace.** Shows how far the tissue has moved relative to its quietest state at each time point. Peaks correspond to the moments of maximum contraction. The baseline between beats should ideally be close to zero. A rising or oscillating baseline indicates wave propagation across the field of view or other spatial heterogeneity in the beating. Points to look at:

- **Peak regularity**: consistent peak heights indicate stable, rhythmic contraction.
- **Peak shape**: a sharp upstroke and slower relaxation are characteristic of healthy cardiac tissue.
- **Baseline stability**: a flat baseline between beats indicates that the tissue is truly at rest between contractions.

**Speed trace.** Shows how rapidly pixels change intensity across the whole field at each time point. It reflects the velocity of the contraction wave passing through the field of view rather than the absolute displacement. Peaks in the speed trace should precede or coincide with peaks in the contraction trace.

**Pixel variance stack.** Open `*_PixelVariance.ome.tiff` in Fiji or napari to see where in the image motion occurs at each time point. Bright regions are pixels that change rapidly. This lets you confirm that the correct tissue region is captured and identify any spatial heterogeneity in the contraction.

**Normalised versus scaled.** *Scaled* values are in pixel or physical units (µm, µm/s) and can be compared in absolute terms. *Normalised* values are rescaled to the range 0 to 1 for each recording, which is useful for comparing shapes and timing but removes information about absolute magnitude.

### Notes and limitations

- Only the **first channel** of a file is analysed.
- Each file must contain a **time series** (more than one frame).
- Files must be in a **single folder**. Sub-folders are not scanned.
- Automatic beat rate detection can select a harmonic instead of the true beat rate. Always check the autocorrelation plot.
- The default video rate (1 fps) and pixel calibration (1 µm/px) are placeholders. Enter the values of your recording.
- Large files can exhaust the computer's memory, especially during the pixel variance calculation. In batch mode, process fewer files at a time, and close napari and other programs before running.
- Do not modify the code in Cell 2. Change settings through the form in Cell 1.

### Reading error messages

If a cell fails, a red block appears below it. Scroll to the **last line** of that block. It is usually the most informative. Typical examples:

| Last line of the error | Usual cause |
|---|---|
| `FileNotFoundError` | The input directory or file name in the form is wrong, or the file was moved |
| `ModuleNotFoundError: No module named ...` | Jupyter was not started from the correct environment, or the package was not installed (Step 3) |
| `NameError: name '...' is not defined` | A cell above was not run (run Cell 1, click **Submit parameters**, then run Cell 2) |

Also see [Troubleshooting](#troubleshooting).

## Closing down

When finished with an analysis:

1. Save the notebook if desired (**File > Save Notebook**).
2. Go to **File > Close and Shut Down Notebook** and confirm. Close any open napari windows.
3. Close the JupyterLab browser tab. To stop the Jupyter server completely, you can also use **File > Shut Down** in JupyterLab.
4. Go to the Anaconda Prompt window and press `Ctrl+C` to stop Jupyter. If asked whether to shut down the server, type `y` and press `Enter`.
5. Deactivate the environment:

   ```
   conda deactivate
   ```

6. Close the Anaconda Prompt.

Next time, you only need to repeat Step 4.

## Video conversion to TIFF sequence

The notebook reads image data. If your recordings are videos (for example `.mov` files from a camera or phone), convert them into a sequence of single TIFF images, one per frame, before analysis. There are two options.

> **Important:** according to the notebook documentation, each file the notebook analyses must be a single **multi-frame time series**, and a file with only one frame cannot be analysed. If the conversion below gives you one TIFF file per frame, combine the frames into a single multi-frame stack before analysis, for example in Fiji (**File > Import > Image Sequence...**, then **File > Save As > OME-TIFF**). Place the resulting file in a separate folder from the single-frame files.

### Option 1: Online converter (small videos)

Convert movies from `.mov` to a TIFF sequence via <https://mconverter.eu/convert/mov/tiff/>:

1. Drag and drop the `.mov` file for conversion.
2. Select `.tiff` as the output format.
3. Download as `.zip` and extract it into a folder (or download individual files, which is much slower).

This option only works for videos smaller than 100 MB. Note that the file is uploaded to a third-party service, so do not use it for confidential data.

### Option 2: FFMPEG (any video size, runs locally)

For videos larger than 100 MB, or if data must stay on your computer, use FFMPEG, a free command-line program.

**Install FFMPEG.** Either:

- Follow this video guide: <https://www.youtube.com/watch?v=OspDzkCKFKE&t=189s>. Please note that you will require admin rights on your PC to change environment variables. Or:
- Install it inside your conda environment, which does not require changing system settings. With the environment active, run:

  ```
  conda install -c conda-forge ffmpeg -y
  ```

Check that the installation worked by typing `ffmpeg -version`. It should print version information rather than an error. (If you installed FFMPEG into the conda environment, you will need to have the environment activated whenever you use it.)

**Navigate to your video folder.** In the Anaconda Prompt use `cd` as in Step 4 to go to the folder containing the video(s). Useful commands to find your way around:

| Task | Windows | macOS / Linux |
|---|---|---|
| Show the files in the current folder | `dir` | `ls` |
| Go into a folder | `cd foldername` | `cd foldername` |
| Go up one level | `cd ..` | `cd ..` |
| Switch drive | `D:` or `cd /d D:\folder` | not needed |

**Run the conversion.** General form of an FFMPEG command:

```
ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...
```

Once in the folder that contains the video(s), type the following command (adapt the file names):

```
ffmpeg -i IMG_3685.mov -pix_fmt rgba IMG_3685_stills_%04d.tif
```

- `IMG_3685.mov`: the input file name.
- `-pix_fmt rgba`: sets the pixel format to RGBA.
- `IMG_3685_stills_%04d.tif`: the output file name and type (TIFF). `%04d` stands for a sequential number with four digits. With the example above the output files will be called `IMG_3685_stills_0001.tif`, `IMG_3685_stills_0002.tif`, `IMG_3685_stills_0003.tif` and so on. For longer videos (more than 9999 frames) use more digits, for example `%08d`.

The output files are written into the same folder as the input files unless a different folder is specified in the command. Press `Enter` to start the conversion. Various parameters of the video are displayed, and the last line gives a running update on the exported frames. Once the conversion has finished, the command line is ready for the next command, for example to convert the next video. When done, close the command line window.

Tips:

- Put each video's frames into their **own folder** so that sequences do not mix.
- A video can contain thousands of frames, and TIFF files are large. Check that you have enough free disk space.
- Use the same naming pattern for all your videos, so that the numbers in the file names sort correctly.

## Troubleshooting

| Problem | What to try |
|---|---|
| `conda` is not recognised | Open the **Anaconda Prompt** from the Start menu instead of the normal Windows Command Prompt |
| `jupyter` is not recognised | The environment is not active. Run `conda activate jupyter-napari-env` (the prompt should start with `(jupyter-napari-env)`) |
| The browser does not open | Copy the `http://localhost:8888/...` address from the prompt window into Chrome |
| The page asks for a password or token | Copy the full address including the `?token=...` part from the prompt window |
| I cannot see my data in the file browser | JupyterLab only shows the folder it was started from. Move or copy the data into the repository folder, or start from a folder that contains both. Typing the full path in the code usually still works |
| `ModuleNotFoundError` | Jupyter is running from the wrong environment. Close it, activate `jupyter-napari-env`, and start again. If the package is truly missing, rerun the `pip install` command in Step 3 |
| Error mentioning Java or JVM when using `bioio-bioformats` | This reader needs Java. See the `bioio-bioformats` documentation for the current installation requirements (it can typically be installed from the conda-forge channel) |
| Sliders, buttons or drop-down menus do not appear | Check that `ipywidgets` is installed (Step 3), then restart the kernel and refresh the browser page. Chrome is recommended |
| The napari window does not appear | Look in the taskbar or Dock. It may be behind the browser window. Restart the kernel and re-run the cell if needed |
| Cell 2 ignores my settings or uses the wrong file | **Submit parameters** was not clicked after the last change in the form. Click it again, then re-run Cell 2 |
| Time axis or units look wrong (seconds or µm values implausible) | **Video rate (fps)** and **Pixel calibration (µm/px)** are still at their placeholder values. Enter the values of your recording and submit again |
| The contraction trace is flat or very noisy | Usually a mismatch between the offset window and the beat period. Enable **Calculate offset**, or set the offset manually to approximately 15 to 25 % of the number of frames per beat. Also check that the correct channel is the first channel in the file |
| The beat rate is detected incorrectly | Check the autocorrelation plot. If the red dot is on a secondary peak, switch to manual beat rate entry |
| A `.czi` file cannot be opened | The notebook tries `bioio-czi` first and falls back to `bioio-bioformats`. Make sure both are installed and that the file is not open in another program. Very large files may time out. Try converting to OME-TIFF in Fiji (**File > Save As > OME-TIFF**) |
| No output files for a file | Check the messages printed below Cell 2 for that file. Common causes are a wrong path, an unsupported format, or a file with only one frame |
| Memory errors during batch processing | Process fewer files per run, close napari and other programs, or use a computer with more memory |
| The notebook seems frozen (`[*]` for a long time) | Large images take time. If nothing happens for several minutes, click the **Stop** (square) button and then **Kernel > Restart Kernel**, and run the cells again from the top |
| "Kernel died" or out-of-memory messages | The data is too large for the available memory. Close other programs, or analyse a shorter or smaller portion of the data |
| `FileNotFoundError` | Check the **Input directory** and **File name** in the form: spelling, a missing file extension, or a file that was moved. Click **Submit parameters** again after correcting them |
| The prompt appears stuck after `jupyter lab` | This is normal. Jupyter runs in this window. Leave it open and use the browser. Press `Ctrl+C` only when you are finished |
| The port 8888 is already in use | An earlier Jupyter session is still open. Close it, or let Jupyter use the next port it suggests |

To remove the environment completely (for example to start over), run `conda deactivate` and then `conda env remove --name jupyter-napari-env`.

## Glossary

| Term | Meaning |
|---|---|
| **Anaconda Prompt / Terminal** | Text window for typing commands |
| **conda** | Program that installs Python and manages environments |
| **Environment** | An isolated set of Python packages (here `jupyter-napari-env`) |
| **Package** | A software library that adds functions to Python (for example `napari`, `matplotlib`) |
| **JupyterLab** | The browser-based program in which notebooks are opened and run |
| **Notebook (`.ipynb`)** | A document combining text, code and results |
| **Cell** | A block of text or code in a notebook |
| **Kernel** | The Python process that runs the code of the notebook |
| **Widget** | An interactive element (slider, button, menu) inside the notebook |
| **napari** | A viewer for multi-dimensional images, opened in its own window |
| **Autocorrelation** | A measure of how similar a signal is to a time-shifted copy of itself. Used here to find the repeating period of the beating signal |
| **Beat rate** | How often the tissue contracts, in Hz (beats per second) or BPM (beats per minute) |
| **Contraction** | Change in tissue structure relative to a quiet reference frame. A proxy for contraction amplitude |
| **Key frame** | The frame with the least motion (tissue at rest), used as the reference for the contraction calculation |
| **Normalised** | Rescaled to the range 0 to 1 by subtracting the minimum and dividing by the range |
| **Offset** | The number of frames in the rolling window used for the pixel variance calculation |
| **OME-TIFF** | A standard microscopy image format that stores pixel size and time interval together with the image |
| **Pixel calibration** | The physical size of one pixel in µm per pixel |
| **Pixel variance** | The standard deviation of a pixel's intensity over a rolling time window. High values mean the pixel is changing quickly, i.e. local motion |
| **Savitzky-Golay filter** | A smoothing filter that preserves the height and shape of peaks while reducing noise |
| **Speed** | A whole-image measure of motion velocity: the pixel variance averaged over all pixels at each time point |
| **Time series** | A sequence of images acquired at regular time intervals (Height x Width x Time) |
| **TIFF sequence** | A series of numbered image files, one per video frame |
| **FFMPEG** | A free command-line tool to convert videos |
| **Path** | The location of a file or folder on your computer, for example `C:\Data\Experiment1` |

## Licence

This project is released under the AGPL-3.0 licence. See the `LICENSE` file.
