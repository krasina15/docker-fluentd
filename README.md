# Дорогой Денис,

Привет, дружище! 👋

Я слышал, тебе нужна помощь с этой компьютерной штукой, которая отправляет логи на другую компьютерную штуку. Не волнуйся, я объясню тебе всё так, будто мы играем в ЛЕГО!

## Что Это За Штука? 🤔

Представь, что у тебя есть куча игрушечных роботов (твои приложения), и все они ведут дневники (логи) в разных папках. Этот специальный робот, которого мы строим (Fluentd), читает все эти дневники и отправляет их в большую библиотеку (Elasticsearch), где ты сможешь легко найти их позже!

## Что Тебе Нужно Сначала, Денис 📝

Перед тем как начать, тебе нужны эти вещи на компьютере:
- Docker (это как коробка, в которой живёт наш робот)
- Твои приложения уже должны писать логи в папки `/apps/logs/`
- Сервер Elasticsearch (большая библиотека) должен где-то работать

## Как Построить Твоего Робота Для Отправки Логов 🤖

### Шаг 1: Скопируй Мой Пример Настроек
Денис, сначала тебе нужно скопировать мой файл-пример:
```bash
cp .env.example .env
```
(Это как списывать домашку, но сейчас это разрешено!)

### Шаг 2: Скажи Роботу, Где Твоя Библиотека
Открой файл `.env` и измени эти вещи:
```
SERVER_NAME=denis-крутой-сервер
ELASTICSEARCH_HOST=где-твоя-библиотека
ELASTICSEARCH_PASSWORD=твой-секретный-пароль
```

Помни, Денис, НИКОГДА не делись своим паролем ни с кем! Даже с лучшим другом!

### Шаг 3: Запусти Своего Робота
Введи это волшебное заклинание:
```bash
docker-compose up -d
```

Вот и всё! Твой робот теперь работает! 🎉

## Как Это Работает? 🔍

Денис, вот что происходит:
1. Твои приложения пишут свои дневники в `/apps/logs/крутоеприложение/app.log`
2. Наш робот смотрит во ВСЕ папки, которые подходят под `/apps/logs/*/app.log`
3. Он читает название папки (типа "крутоеприложение"), чтобы знать, какое приложение это написало
4. Он отправляет всё в Elasticsearch с именем типа: `denis-крутой-сервер-крутоеприложение-2025.05.19`

Самое классное: если ты добавишь новое приложение, робот автоматически найдёт его логи тоже! Никакой лишней работы!

## Если Что-то Пошло Не Так 😢

Денис, если твой робот не работает:

1. Посмотри, что он говорит:
```bash
docker-compose logs fluentd
```

2. Убедись, что твои приложения действительно пишут логи туда, куда надо:
```bash
ls -la /apps/logs/
```

3. Проверь, работает ли твой робот:
```bash
docker ps | grep fluentd
```

## Как Заставить Робота Делать Разные Вещи 🛠️

Денис, если твои логи выглядят по-другому (может, они не JSON), тебе нужно изменить файл `fluent.conf`. Но будь осторожен! Одна неправильная буква - и робот запутается!

## Важные Заметки Для Тебя, Денис! ⚠️

- Всегда запускай это на Linux или Mac (Windows иногда странно себя ведёт)
- Убедись, что Docker может читать твою папку `/apps/logs`
- Если ты остановишь приложение, его старые логи всё ещё останутся в Elasticsearch
- Робот проверяет новые логи каждые 5 секунд

## Нужна Ещё Помощь? 🆘

Денис, если ты всё ещё запутался:
1. Спроси взрослого, который знает Docker
2. Прочитай официальную документацию Fluentd (но она скучная)
3. Попробуй выключить и включить снова (серьёзно, иногда это работает!)

Удачи с твоим лог-роботом, Денис! У тебя всё получится! 💪

Твой друг,
Автор README

P.S. - Не забудь почистить зубы и сделать домашку! Но сначала отправь эти логи! 📚



# Dear Denis,

Hi there buddy! 👋

I heard you need help with this computer thingy that sends logs to another computer thingy. Don't worry, I'll explain it like we're playing with LEGOs!

## What Is This Thing? 🤔

Imagine you have a bunch of toy robots (your apps) and they all keep diaries (logs) in different folders. This special robot we're building (Fluentd) reads all those diaries and sends them to a big library (Elasticsearch) where you can find them easily later!

## What You Need First, Denis 📝

Before we start, you need these things on your computer:
- Docker (it's like a box that holds our robot)
- Your apps already writing logs to `/apps/logs/` folders
- An Elasticsearch server (the big library) running somewhere

## How to Build Your Log-Sending Robot 🤖

### Step 1: Copy My Example Settings
Denis, first you need to copy my example file:
```bash
cp .env.example .env
```
(This is like copying homework, but it's allowed this time!)

### Step 2: Tell the Robot Where Your Library Is
Open the `.env` file and change these things:
```
SERVER_NAME=denis-awesome-server
ELASTICSEARCH_HOST=where-your-library-is
ELASTICSEARCH_PASSWORD=your-secret-password
```

Remember Denis, NEVER share your password with anyone! Not even your best friend!

### Step 3: Start Your Robot
Type this magic spell:
```bash
docker-compose up -d
```

That's it! Your robot is now running! 🎉

## How Does It Work? 🔍

Denis, here's what happens:
1. Your apps write their diaries in `/apps/logs/coolapp/app.log`
2. Our robot looks in ALL folders that match `/apps/logs/*/app.log`
3. It reads the folder name (like "coolapp") to know which app wrote it
4. It sends everything to Elasticsearch with a name like: `denis-awesome-server-coolapp-2025.05.19`

The cool part is: if you add a new app, the robot automatically finds its logs too! No extra work needed!

## If Something Goes Wrong 😢

Denis, if your robot isn't working:

1. Look at what it's saying:
```bash
docker-compose logs fluentd
```

2. Make sure your apps are actually writing logs where they should:
```bash
ls -la /apps/logs/
```

3. Check if your robot is running:
```bash
docker ps | grep fluentd
```

## Making Your Robot Do Different Things 🛠️

Denis, if your logs look different (maybe they're not JSON), you need to change the `fluent.conf` file. But be careful! One wrong letter and the robot gets confused!

## Important Notes for You, Denis! ⚠️

- Always run this on Linux or Mac (Windows is weird sometimes)
- Make sure Docker can read your `/apps/logs` folder
- If you stop an app, its old logs still stay in Elasticsearch
- The robot checks for new logs every 5 seconds

## Need More Help? 🆘

Denis, if you're still confused:
1. Ask a grown-up who knows Docker
2. Read the official Fluentd documentation (but it's boring)
3. Try turning it off and on again (seriously, this works sometimes!)

Good luck with your log robot, Denis! You got this! 💪

Your friend,
The README Writer

P.S. - Don't forget to brush your teeth and do your homework! But first, get those logs shipped! 📚