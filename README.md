memberbook.co.kr
---

# Travis CI
[![Build Status](https://magnum.travis-ci.com/dobestan/memberbook.co.kr.svg?token=EYvfmGtgmwuF771jvzh8&branch=develop)](https://magnum.travis-ci.com/dobestan/memberbook.co.kr)

# Requirements
```
$ brew install postgresql
$ createdb
$ psql
psql(9.3.5)
Type "help" for help.

user=# create role memberbook with createdb login password 'memberbook';
```

# Foreman
- RailsCast <Foreman> : http://railscasts.com/episodes/281-foreman

```
$ foreman check
valid procfile detected (web)
```

- 프로세스들을 추후에 한번에 관리할 수 있다.
- 현재는 unicorn 웹 서버만을 관리한다. ( 유니콘 웹 서버가 3개의 프로세스를 관리하도록 설정 )
```
$ foreman start
17:20:01 web.1  | started with pid 95512
17:20:02 web.1  | I, [2014-11-20T17:20:02.414654 #95512]  INFO -- : Refreshing Gem list
17:20:03 web.1  | I, [2014-11-20T17:20:03.934820 #95512]  INFO -- : listening on addr=0.0.0.0:5000 fd=10
17:20:04 web.1  | I, [2014-11-20T17:20:04.101589 #95512]  INFO -- : master process ready
17:20:04 web.1  | I, [2014-11-20T17:20:04.106204 #95516]  INFO -- : worker=1 ready
17:20:04 web.1  | I, [2014-11-20T17:20:04.106205 #95515]  INFO -- : worker=0 ready
17:20:04 web.1  | I, [2014-11-20T17:20:04.106283 #95517]  INFO -- : worker=2 ready
```

- 이렇게 되면 web process 가 2개가 띄어진다.
- 즉, unicorn 프로세스는 총 6개가 띄어진다. ( 성능상의 이점이 있는건가? )
```
$ foreman start -c web=2
```

# Mina - Fast Deployment

```
$ mina setup --verbose
```

```
$ mina deploy --verbose
```
