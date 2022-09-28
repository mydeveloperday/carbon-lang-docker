FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt install -y apt-transport-https curl wget gnupg

# LLVM and Clang
RUN apt-get install -y llvm
RUN apt-get install -y clang-14
RUN apt-get install -y lld-14
RUN apt-get install -y build-essential
RUN apt-get install -y libunwind-dev
RUN apt-get install -y libc++-dev

# Setup Clang compiler links
RUN ln -s /usr/bin/clang-14 /usr/bin/clang
RUN ln -s /usr/bin/clang++-14 /usr/bin/clang++

# Bazel Setup
RUN curl -kfsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt update
RUN apt install -y bazel

# Overcome SSL certificate issue by pre-downloading the dependencies
# Avoid failed: class javax.net.ssl.SSLHandshakeException PKIX by pre-downloading packages
RUN mkdir -p /usr/local/bazelbuild
RUN echo "build --distdir=/usr/local/bazelbuild" > ~/.bazelrc

# Versions may need to change from time to time
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.1.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/llvm/llvm-project/archive/6fa65f8a98967a5d2d2a6863e0f67a40d2961905.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/jmillikin/rules_m4/archive/v0.2.1.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/jmillikin/rules_flex/archive/1f1d9c306c2b4b8be2cb899a3364b84302124e77.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/jmillikin/rules_bison/archive/478079b28605a38000eaf83719568d756b3383a0.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0-3.20.0.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/bazelbuild/rules_cc/releases/download/0.0.1/rules_cc-0.0.1.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://ftp.gnu.org/gnu/bison/bison-3.3.2.tar.xz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/jmillikin/rules_bison/releases/download/v0.1/bison-gnulib-788db09a9f88abbef73c97e8d7291c40455336d8.tar.xz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.xz
RUN wget --no-check-certificate -qP /usr/local/bazelbuild/ https://github.com/jmillikin/rules_m4/releases/download/v0.1/m4-gnulib-788db09a9f88abbef73c97e8d7291c40455336d8.tar.xz

# Dev Environment files
RUN apt-get install -y vim
RUN apt-get install -y git

# Mount /carbon-lang directory via docker command line





