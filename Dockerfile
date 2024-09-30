FROM ubuntu

RUN apt-get update \
	&& apt-get install -y \
	curl \
	git \
	python3 \
	sudo \
	vim \
	wget \
	zsh \
  build-essential

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
	&& tar -C /opt -xzf nvim-linux64.tar.gz \
  && ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

ARG USER=rufo
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}
RUN mkdir -p /home/${USER}/.local/share

ARG CHEZMOI_VERSION=2.52.2
ARG CHEZMOI_ARCH
RUN curl -LO https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi_${CHEZMOI_VERSION}_linux_${CHEZMOI_ARCH}.deb \
  && sudo dpkg -i chezmoi_${CHEZMOI_VERSION}_linux_${CHEZMOI_ARCH}.deb \
  && rm chezmoi_${CHEZMOI_VERSION}_linux_${CHEZMOI_ARCH}.deb
