# --------------------------------------------------------------------------------------------------
# Builder Image
# --------------------------------------------------------------------------------------------------
FROM ubuntu

ENV KUBECTL_VERSION "1.25.4"
ENV HELM_VERSION "3.11.1"
ENV KOPS_VERSION "1.25.3"

RUN apt update -y && apt install -y curl git

RUN curl -sLO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

RUN curl -sLO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    chmod +x ./linux-amd64/helm && \
    mv ./linux-amd64/helm /usr/local/bin/helm 

RUN curl -sLO https://github.com/kubernetes/kops/releases/download/v${KOPS_VERSION}/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/local/bin/kops

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens

RUN echo 'alias k="kubectl"' >> ~/.bashrc
RUN echo 'alias kx="kubectx"' >> ~/.bashrc

    