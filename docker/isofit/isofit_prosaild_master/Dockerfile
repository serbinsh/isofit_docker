# ----------------------------------------------------------------------
# Debian isofit docker container
# ----------------------------------------------------------------------

FROM gcc:7.4.0
MAINTAINER S.P. Serbin email: sserbin@bnl.gov

RUN useradd -ms /bin/bash isofit

# Set a few variables that can be used to control the docker build
ARG LIBRADTRAN=2.0.2

# Update the system and install initial dependencies
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
    cmake \
    git \
    subversion \
    bzip2 \
    libgmp3-dev \
    m4 \
    wget \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libxml2 \
    libxml2-dev \
    csh \
    libffi6 \
    libffi-dev \
    libxml-libxml-perl \
    libxml2-utils \
    vim \
    libudunits2-0 \
    libudunits2-dev \
    udunits-bin \
    htop \
    python2.7 \
    python-dev \
    python-pip \
    python3 \
    python3-pip \
    apt-utils \
    ftp \
    apt-transport-https \
    locales \
    libjson-c3 \
    libjson-c-dev \
    libjson-perl \
    netcdf-bin \
    libnetcdf-dev \
    libhdf5-serial-dev \
    autopoint \
    gsl-bin \
    libgsl0-dev \
    llvm \
    bison

## Compile Expat XML parser
RUN echo "*** Compiling Expat XML parser"
RUN cd / \
    && wget https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2 \
    && tar -xvjf expat-2.2.6.tar.bz2 \
    && cd expat-2.2.6 \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && rm -r expat-2.2.6 \
    && rm expat-2.2.6.tar.bz2

    ## build FLEX
RUN echo "*** Compiling FLEX "
RUN cd / \
    && wget https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz \
    && tar -zxvf flex-2.6.4.tar.gz \
    && cd flex-2.6.4 \
    && ./autogen.sh \
    && ./configure && make && make install \
    && cd / \
    && rm flex-2.6.4.tar.gz \
    && rm -r flex-2.6.4

    ## build libradtran
RUN echo "*** Compiling libradtran " ${LIBRADTRAN}
RUN cd / \
    && wget http://www.libradtran.org/download/libRadtran-${LIBRADTRAN}.tar.gz \
    && tar -zxvf libRadtran-${LIBRADTRAN}.tar.gz \
    && cd libRadtran-${LIBRADTRAN} \
    && ./configure \
    && make \
    && cd /libRadtran-${LIBRADTRAN} \
    && wget -O reptran_2017_all.tar.gz http://www.meteo.physik.uni-muenchen.de/~libradtran/lib/exe/fetch.php?media=download:reptran_2017_all.tar.gz \
    && tar -zxvf reptran_2017_all.tar.gz \
    && rm reptran_2017_all.tar.gz \
    && cd / \
    && rm libRadtran-${LIBRADTRAN}.tar.gz \
    && chown isofit -R /libRadtran-${LIBRADTRAN}

    ## build Python modules
RUN echo "*** Installing Python3 Modules "
RUN cd / \
    && pip3 install --upgrade pip \
    && python3 -m pip install 'llvmlite==0.15.0' \
    && python3 -m pip install numpy \
    && python3 -m pip install scipy \
    && python3 -m pip install matplotlib \
    && python3 -m pip install numba \
    && python3 -m pip install scikit-learn \
    && python3 -m pip install spectral \
    && python3 -m pip install pytest \
    && python3 -m pip install pep8 \
    && python3 -m pip install xxhash

    ## Grab isofit from GitHub 
RUN echo "*** Installing isofit "
RUN cd / \
    && git -c http.sslVerify=false clone https://github.com/isofit/isofit.git \
    && mkdir -p /isofit/examples/20171108_Pasadena/lut \
    && chown isofit -R /isofit \
    && chmod 775 -R /isofit

    ## Create general output directory
RUN cd / \
    && mkdir -p output \
    && chown isofit -R /output \
    && chmod 775 -R /output

    ## build PROSAIL_D
RUN echo "*** Compiling PROSAIL_D "
RUN cd / \
    && wget http://teledetection.ipgp.jussieu.fr/prosail/PROSAIL_D_Fortran.zip \
    && unzip PROSAIL_D_Fortran.zip \
    && chown isofit -R /PROSAIL_D_FORTRAN \
    && chmod 775 -R /PROSAIL_D_FORTRAN \
    && cd PROSAIL_D_FORTRAN \
    && rm main_PROSAIL.f90 \
    && wget https://raw.githubusercontent.com/serbinsh/prosail_docker/master/src/prosail_d/main_PROSAIL.f90 \
    && gfortran -o prosail.exe MODULE_PRO4SAIL.f90 dataSpec_PDB.f90 main_PROSAIL.f90 LIDF.f90 dladgen.f PRO4SAIL.f90 prospect_DB.f90 tav_abs.f90 volscatt.f90 \
    && ./prosail.exe 1.5 55 2 2 0 0.009 0.009 -0.35 -0.15 1 5 0.1 30 10 0 0.85

    ## Create script folder to hold custom run scripts, plotting scripts, etc
RUN cd / \
    && mkdir -p analysis_scripts \
    && chown isofit -R /analysis_scripts \
    && chmod 775 -R /analysis_scripts \
    && cd /analysis_scripts \
    && wget https://raw.githubusercontent.com/serbinsh/prosail_docker/master/analysis_scripts/simple_prosail_plot.py \
    && chmod 775 simple_prosail_plot.py

    ## change permissions on tmp dirs to use in isofit
RUN cd / \
    && chown isofit -R /tmp \
    && chmod 775 -R /tmp \
    && chown isofit -R /var/tmp \
    && chmod 775 -R /var/tmp

    ## Set Python Path and other environment variables
ENV PYTHONPATH="${PYTHONPATH}:/isofit/isofit:/isofit/utils"
ENV ISOFIT_BASE=/isofit
ENV LIBRADTRAN_DIR=/libRadtran-${LIBRADTRAN}

### EOF
