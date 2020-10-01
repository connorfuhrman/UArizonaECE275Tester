# University of Arizona ECE 275
### Dockerfile used to generate connorfuhrman/uariozna-ece275-tester image

## Purpose
This dockerfile serves to test student programs in ECE 275 at the University of Arizona. The docker image is build of GCC 10 and contains CMake and the Boost C++ library (in its entirety) along with Python3's pytest library used for output comparison tests.
 
## Use case
This docker container is used in conjunction with the UArizona's GitLab server. An exmample .gitlab-ci.yml file is shown below:

``` yml
image: connorfuhrman/uarizona-ece275-tester:0.1

before_script:
  - mkdir build && cd build
  - cmake ..
  - make -j2

run-test:
  script:
    - cd Tester && ctest -V
```

## Contact
Email: connorfuhrman at email dot arizona dot edu