# AI-lab: A development environment for AI-based computer vision application
<!-- TOC -->

- [AI-lab: A development environment for AI-based computer vision application](#ai-lab-a-development-environment-for-ai-based-computer-vision-application)
	- [Description](#description)
	- [Install AI-lab](#install-ai-lab)
	- [Start developing](#start-developing)
		- [Jupyter notebook](#jupyter-notebook)
		- [VS Code](#vs-code)
	- [Do you any suggestions ?](#do-you-any-suggestions-)

<!-- /TOC -->

## Description
This project is reserved for creating a new development environment using docker for exporting AI models in data science, and specially, computer vision. 

I hand-crafted AI-lab to take advantage of docker capability to have a reproducible and portable development environment. It allows you developing your artificial intelligence based computer vision application in Python using the most used artificial intelligence frameworks.

AI-lab is meant to be used to build, train, validate and test your deep learning models.

	- Ubuntu 18.04
	- NVIDIA CUDA 10.1
	- NVIDIA cuDNN 7.6.0
	- OpenCV 4.1.0
	- Python 3.6
	- Most used AI framework: 
    	- TensorRT
      	- TensorFlow
      	- PyTorch
      	- ONNX
      	- Keras
      	- ONNX-TensorRT
	- Jupyter-lab
	- VS Code integration with remote development
	- and more

## Install AI-lab
First, you must have `docker-ce` installed on your machine to be able to use the pre-configured development environment. To do that, simply follow the steps to install [docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/), or select the suitable version depending on your OS.


* Pull AI-lab from Docker Hub
  
	```bash
		docker pull aminehy/ai-lab
	```

* Run the AI-lab and start your development

	* Move to your application folder
	``` bash
		cd /folder/application
	```

	* then run AI-lab
	``` bash
		xhost +

		docker run -it --rm -v $(pwd):/workspace \
		--runtime=nvidia -w /workspace \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$DISPLAY \
		-p 8888:8888 aminehy/ai-lab:latest
	```

## Start developing 
### Jupyter notebook
If AI-lab runs correcly on your machine then `Jupyter notebook` should run automatically. If this is not the case, launch it from the terminal with this command

```bash 
jupyter notebook --allow-root --port=8888 --ip=0.0.0.0 --no-browser
```
### VS Code

coming soon


## Do you have any suggestions ?

Please contact me and let me know.
LinkedIn - https://www.linkedin.com/in/aminehy/
