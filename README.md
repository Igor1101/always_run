# ALWAYS RUN
Набір скриптів які дозволяють легко розповсюдити серед серверів на GNU\Linux

однакову задачу, наприклад для розподілених обчислень

(задача сама має визначати зв'язки між  серверами якщо вони потрібні).
### Залежності які треба встановити
tmux, openssh-client, sshpass, bash, curl
### Набір файлів
| назва файлу | призначення                                                            |
|-------------|------------------------------------------------------------------------|
|conf.sh      | файл налаштувань щодо запуску задачі                                   |
|cp.sh        | використовується для розповсюдження, оновлення всіх файлів на серверах |
|hosts.txt    | файл, в якому слід вписати ipv4 адреси серверів у форматі X.X.X.X      |
|init.sh      | файл, який необхідно визвати для запуску задачі на відповідному сервері|
|README.md    | документація                                                           |
|run.sh       | додатковий файл, необхідно для роботи скриптів, в циклі виконує задачу |
|user\_code.sh| файл, у який можна записати саму задачу або ж код, який її визиватиме  |
|status.sh    | відобразить статус сесій на всіх серверах з файлу hosts.txt            |
|killall.sh   | вимкне всі сесії даної задачі (tmux) на всіх серверах                  |
|\*           | будь-які інші файли додані в дану директорію будуть також скопійовані  |
|cpk.sh       | використовується для розповсюдження, оновлення всіх файлів на серверах |
|statusk.sh   | відобразить статус сесій на всіх серверах з файлу hosts.txt            |
|killallk.sh  | вимкне всі сесії даної задачі (tmux) на всіх серверах                  |

### Інструкція щодо запуску

Першочергово необхідно на серверах створити нового користувача з однаковою назвою та однаковим паролем(наприклад, *user123*, *password123*):
```
useradd user123 -m -s /bin/bash -G sudo .....
passwd user123....
```
Також можна використати ключі ssh для автентифікації. 
Вписати у файл hosts.txt адреси усіх серверів(X.X.X.X) кожна з нового рядочка. 
Наприклад:
```
13.4.56.4
3.4.5.5
124.32.42.32
```
Наступні етапи вже можна робити багато разів(виправляти щось і надсилати файли для роботи знову) повторювати оскільки передача файлів на сервери вже налаштована.

Додати свою задачу або визов задачі у файл user\_code.sh.
За необхідності відредагувати налаштування в файлі conf.sh (скрипти самодокументовані).

Запустити файл cp.sh. Саме цей файл скопіює всю директорію на віддалений сервер та 
перезапустить задачу always\_run(задача запускається в tmux сесії *always_run*).
Буде також скопійовано файли теки always\_run в /home/user123/always\_run.
Повторний виклик команди cp.sh оновить всі файли та перезапустить сесії.
Приклад запуску cp.sh:
```
bash cp.sh user123 password123
```
те ж саме з ssh ключем:
```
bash cpk.sh user123 /path/to/key
```
те ж саме з ssh ключем, шлях до якого попередньо вами записаний у файл conf.sh у парамерт 
DEFAULT_KEY_PATH
```
bash cpk.sh user123 
```


Додатково існують такі опції:

видалення всіх сесій на всіх серверах(вміст файлів не видаляється але сесії tmux закриваються і задача завершується(SIGKILL сигнал для вашої задачі):

```
bash killall.sh user123 password123
bash killallk.sh user123 /path/to/key
bash killallk.sh user123 
```

статус(стан роботи tmux сесій):
```
bash status.sh user123 password123
bash statusk.sh user123 /path/to/key
bash statusk.sh user123 
```

Зверніть увагу, що після виклику і успішного виконання команди cp.sh можна керувати серверами за допомогою цих команд зайшовши на будь-який з них.
Налаштування прав користувачів залишається за адміністратором.
