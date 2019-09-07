FROM  ufoym/deepo:all-py36-jupyter-cpu

# Install additional packages
RUN pip install --upgrade pip
RUN pip install ipyparallel && jupyter nbextension install --py ipyparallel && jupyter nbextension enable --py ipyparallel && jupyter serverextension enable --py ipyparallel
RUN pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install
RUN pip install jupyter-tensorboard && jupyter nbextension install --py jupyter_tensorboard
RUN pip install autopep8

# Install missing dependencies
RUN apt-get update && apt-get install -yq \
                libzmq3-dev \
                libssl-dev \
                python-zmq \
                unzip \
                curl \
                git \
        && \
        apt-get clean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/*

# Install xelatex to download as PDF the notebooks
RUN add-apt-repository universe && apt-get update && apt-get install -yq \
                pandoc \
                texlive-xetex \
                texlive-generic-extra \
        && \
        apt-get clean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/*

# Install the latest versions of nn, and iTorch
RUN luarocks install nn && \
    luarocks install loadcaffe && \
        \
        cd /root && git clone https://github.com/facebook/iTorch.git && \
        cd iTorch && \
        luarocks make

# Install Jupyter Lab
RUN pip install jupyter jupyterlab notebook pandoc nbconvert --upgrade

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
		apt-get install -y \
		nodejs \		
	&& \
        apt-get clean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/*

# Upgrade pandoc
RUN apt-get update && \
	apt-get upgrade -y \
		pandoc \
		pandoc-citeproc \
		pandoc-data \
        && \
        apt-get clean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/*

# Install Jupyterlab git extension
RUN jupyter labextension install @jupyterlab/git && \
	pip install --upgrade jupyterlab-git && \
	jupyter serverextension enable --py jupyterlab_git

# Install nbdim extension
RUN jupyter serverextension enable --py nbdime && \
	jupyter nbextension install --py nbdime && \
	jupyter nbextension enable --py nbdime && \
        jupyter labextension install nbdime-jupyterlab 

# Install toc extension
RUN jupyter labextension install @jupyterlab/toc

# Add supervisor S6
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Install socklog-overlay
ADD https://github.com/just-containers/socklog-overlay/releases/download/v3.1.0-1/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /

# Add service definition files to start Notebooks and TensorBoar
ADD services.d/notebooks /etc/services.d/notebooks
ADD services.d/tensorboard /etc/services.d/tensorboard
ADD services.d/jupyterlab /etc/services.d/jupyterlab

ENTRYPOINT ["/init"]
