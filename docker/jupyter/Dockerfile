FROM bitnami/spark:3.5

USER root

# Install JupyterLab and Python data packages
RUN pip install --no-cache-dir \
    jupyterlab==4.2.* \
    delta-spark==3.2.0 \
    boto3==1.34.* \
    pandas==2.2.* \
    pyarrow==15.* \
    matplotlib==3.9.* \
    seaborn==0.13.*

# Create notebook directory
RUN mkdir -p /home/notebooks && chmod -R 777 /home/notebooks

USER 1001

EXPOSE 8888

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.token=''", \
     "--NotebookApp.password=''", \
     "--notebook-dir=/home/notebooks"]
