# meddream

### Installation

1. Replace ip address in application.properties with docker host ip (not "localhost")
```sh
com.softneta.meddream.pacs.configurations[0].baseUrl=http://<host ip>:8042
```
2. Build docker image
```sh
$ ./buildDocker.sh
```
3. Start orthanc server
```sh
$ docker run --rm -i -t -p 4242:4242 -p 4812:4812 -p 8042:8042 -e "AuthenticationEnabled=false" --name orthanc osimis/orthanc
```
4. Upload file to Orthanc
    1. http://localhost:8042/app/explorer.html#upload
    2. login with Username:demo / Password: demo
    3. upload the two .dcm files
5. Start MedDream
```sh
docker run --rm -i -t -p 18080:80 -p 18081:8080 --name meddream meddream
```
6. Go to http://localhost:18080/meddream
7. Login with Username:user / Password: (empty)
