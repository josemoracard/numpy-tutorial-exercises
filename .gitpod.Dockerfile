FROM gitpod/workspace-full:latest

USER gitpod

# That Gitpod install pyenv for me? no, thanks
WORKDIR /home/gitpod/
RUN rm .pyenv -Rf
RUN rm .gp_pyenv.d -Rf
RUN curl https://pyenv.run | bash


RUN pyenv update && pyenv install 3.10.7 && pyenv global 3.10.7
RUN pip install pipenv

# remove PIP_USER environment
USER gitpod
RUN if ! grep -q "export PIP_USER=no" "$HOME/.bashrc"; then printf '%s\n' "export PIP_USER=no" >> "$HOME/.bashrc"; fi
RUN echo "" >> $HOME/.bashrc
RUN echo "unset DATABASE_URL" >> $HOME/.bashrc
RUN echo "export DATABASE_URL" >> $HOME/.bashrc


RUN pip3 install pytest==4.6.0 pytest-testdox mock numpy==1.17.4 pandas==0.25.3
RUN npm i @learnpack/learnpack -g && learnpack plugins:install learnpack-python
