# Getting started with ROBOTFRAMEWORK

## to start the test

```bash
    robot -d results ./00_basicTest.robot
```

Oppure

```CMD
    py -m robot -d results ./00_basicTest.robot
```

In caso voglia eseguire un solo test posso usare l'opzione -t '<titolo del test>'


```bash
    robot -d results  -t 'Do a login' ./00_basicTest.robot
```

Oppure

```CMD
    py -m robot -d results  -t 'Do a login'  ./00_basicTest.robot
```
