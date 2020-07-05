# Práctica entorno de monitorización de Kubernetes con Prometheus, Grafana, Alermanager.

Para poder realizar la práctica he instalado un cluster K8S en 2 nodos EC2 de Ubuntu, configurando un master y un slave.


## REQUISITOS

Para hacer que funcione necesitaremos:

  - docker en pc donde ejecutaremos Grafana
  - docker-compose en pc donde ejecutaremos Prometheus y Alermanager
  - k8s, minikube o kind. En este caso, como hemos comentado, utilizaré cluster k8s en ec2.

## ESTRUCTURA


  - Grafana: Ejecutado en local
  - Prometheus y Alertmanager en cluster k8s mediante docker-compose
  - Cadvisor en k8s mediante svc y daemonset

## EJECUCIÓN

  - Lanzamos Grafana desde Makefile, compiamos el comando de docker o ejecutamos. EN mi caso desde local
    ```
    make run-grafana
    sudo docker run --rm -p 3000:3000 --name=grafana grafana/grafana:6.4.4
    ```
  - Volveremos más tarde para configurar el dashboard y el promtheus al que conectar. Por el momento accedemos con admin/admin
  - En cluster de k8s, configuramos el usuario clusterole, para obtener secretos del certificado y bearer token y pasarlo a la codificación correcta:
    ```
    kubectl apply -f prom-rbac.yaml
    kubectl get serviceaccount prometheus -o yaml
    kubectl get secret prometheus-token-s5284 -o yaml
    ```
    ES UN PASO IMPORTANTE Y CLAVE PARA PODER CONECTAR Y OBTENER MÉTRICAS
  - Se deberan incluir en los ficheros: ca-file.crt, bearer.token y la información de los mismos incluirlas en config.yaml de prometheus
  - Creamos el service y daemonset de cadvisor
    ```
    kubectl apply -f service.yaml 
    kubectl apply -f daemonset.yaml
    ```
  - Realizamos lo mismo con los ficheros de kube-state-metrics. Aplicamos deployment.yaml y service.yaml
  - En el fichero config.ymal deberemos indicar nuestro apiserver. En caso de no saberlo:
  
    ```
    kubectl config view
    Debemos buscar: 
    server: https://10.0.1.54:6443 #Es la ip interna del master, pero para acceder a Promtheus se deberá utilizar la ip externa
    ```
  - Ejecutamos docker-compose up para Prometheus y Alertmanager 


## LINKS DE ACCESO A LAS APLICACIONES:

  - Grafana:    http://localhost:3000/ -- Importaremos el dashboard MyPrometheusDashboard.json
                En caso de querer hacer uno de 0, deberemos indicar el datasource a conectar: en mi caso IP de Prometheus 
                http://3.123.23.215:9090 y en Access, indicar Browser.
  - Prometheus: http://3.123.23.215:9090/targets -- verificamos que conectamos y los endpoints estan up.
                http://3.123.23.215:9090/alerts -- alertas configuradas en rules.yaml

  `

## BÚSQUEDA DE INFORMACIÓN
  
   https://stackoverflow.com/

