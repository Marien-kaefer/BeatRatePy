# Cardiac Waveform Analysis of Transmitted Light Time Series Images

## Overview

This repository contains the Matlab/Python code associated with the following paper:
	* INSERT INFO

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
conda install -c conda-forge napari pyqt
pip install notebook
pip install matplotlib
pip install ipywidgets
```

You have successfully set up the necessary conda environment! You do not need to repeat these step unless you require a new environment or you are setting this up on another system. 

## Step 4: Usage

We have found that Jupyter notebooks run well in Google Chrome. 

To start the notebook, open Anaconda prompt and activate your environment, if not yet active, and then launch jupyter notebbok. 

```
conda activate jupyter-napari-env
jupyter notebook
```

A browser window will open within which you can navigate to the location of your notebook. Please note that a single click opens folders amd files. 

When finished with any analysis, save the notebook if desired. Go to [File > Close and Shut Down Notebook]. Close the Jypyter browser tab in you web browser. Then go to the Anaconda prompt window and use [Ctrl C] to stop Jupyter, then deactivate the environment you have created with the following command.
```
conda deactivate
```

Close the Anaconda prompt. 