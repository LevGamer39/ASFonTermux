from mcstatus import MinecraftServer
import sys

def get_server_info(server_ip=None, query_port=None):
    # Если данные не переданы, запрашиваем у пользователя
    if server_ip is None:
        server_ip = input("Введите IP сервера: ").strip()
    
    if query_port is None:
        query_port = input("Введите порт Query: ").strip()
    
    # Проверяем, что порт - число
    try:
        query_port = int(query_port)
    except ValueError:
        print("Ошибка: Порт должен быть числом")
        return
    
    # Подключаемся к серверу
    server = MinecraftServer.lookup(f"{server_ip}:{query_port}")

    try:
        # Получаем статус сервера
        status = server.status()
        print("Информация о сервере:")
        print(f"Описание: {status.description}")
        print(f"Версия сервера: {status.version.name}")
        print(f"Игроки онлайн: {status.players.online}/{status.players.max}")
        print(f"Задержка (пинг): {status.latency} мс")

        # Попробуем получить полную информацию через Query
        try:
            query = server.query()

            print("\nДополнительная информация от Query:")
            print(f"Игроки онлайн: {query.raw['numplayers']}/{query.raw['maxplayers']}")
            print(f"Имя карты: {query.raw['map']}")
            print(f"Сообщение дня: {query.motd}")

            # Проверяем, есть ли игроки
            if query.players:
                print("Список игроков:")
                for player in query.players.names:
                    print(f"- {player}")
            else:
                print("Нет игроков онлайн.")

            # Информация о программном обеспечении сервера
            print("\nИнформация о программном обеспечении сервера:")
            print(f"Тип игры: {query.raw['gametype']}")
            print(f"ID игры: {query.raw['game_id']}")
            print(f"Версия: {query.raw['version']}")
            print(f"Плагины: {query.raw['plugins']}")

        except Exception as e:
            print("Query недоступен на указанном порту:", e)

    except Exception as e:
        print("Не удалось подключиться к серверу:", e)

# Запускаем функцию
if __name__ == "__main__":
    if len(sys.argv) == 3:
        # Используем аргументы командной строки
        get_server_info(sys.argv[1], sys.argv[2])
    else:
        # Запрашиваем у пользователя
        get_server_info()
