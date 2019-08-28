# Managing Python dependencies with VirtualEnv

## The Dilemma
Managing dependencies when working with different projects can be a nightmare.
Suppose you have a **Project-A** using a library `AwesomeLibrary=1.0.0`, we then install this dependency:

```bash
$ pip3 install AwesomeLibrary==1.0.0
```
All is well, but.. let's say you have another **Project-B** that needs `AwesomeLibrary=2.0.0`, then we run
```bash
$ pip3 install AwesomeLibrary==2.0.0
```

Oh no! **Project-A** needs `1.0.0` version while **Project-B** need `2.0.0`! What do we do?

## Introducing VirtualEnv
By default, `pip` installs a package *globally*. To check where your package was installed, run:
```bash
$ pip3 show <package name>
```

For example:
```bash
$ pip3 show requests
Name: requests
Version: 2.22.0
Summary: Python HTTP for Humans.
Home-page: http://python-requests.org
Author: Kenneth Reitz
Author-email: me@kennethreitz.org
License: Apache 2.0
Location: /usr/lib/python3.7/site-packages
Requires: chardet, idna, urllib3
Required-by: Sphinx, httpie, docker, docker-compose, CacheControl
```

Therefore global packages are installed on `/usr/lib/python3.7/site-packages`

VirtualEnv however, installs packages on a *user defined* directory, this gives us the ability to run different versions of the same dependencies. Let's install `virtualenv`
```bash
$ pip3 install virtualenv
```

Then let's create a virtual environment
```bash
$ virtualenv -p python3 ~/my-environment
```

This creates the directory `my-environment`, to point Python here, use:
```bash
$ source ~/my-environment/bin/activate
```

Sweet! Now let us try installing packages:
```bash
$ pip3 install mido

$ pip3 show mido
Name: mido
Version: 1.2.9
Summary: MIDI Objects for Python
Home-page: https://mido.readthedocs.io/
Author: Ole Martin Bjorndalen
Author-email: ombdalen@gmail.com
License: MIT
Location: /home/jed/my-environment/lib/python3.7/site-packages
Requires: 
Required-by: 
```

Awesome! The package `mido` is installed on `/home/jed/my-environment/lib/python3.7/site-packages`. To run your python script, just invoke it as usual:
```bash
$ python3 my-cool-python-script.py
```

Now, suppose we want to *document* the versions of the dependencies we've used, observe:
```bash
$ pip3 freeze > requirements.txt

$ cat requirements.txt
mido==1.2.9
```

This creates a file `requirements.txt`, that lists down all dependencies we've used with their versions. We can easily install these with:
```bash
$ pip3 install -r requirements.txt
```

Nice! Now we can commit the `requirements.txt` file to our project repository ;)

Lastly, if you wish to leave your virtual environment just run:
```bash
$ deactivate
```