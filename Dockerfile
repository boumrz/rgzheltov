# Используйте официальный Node.js образ как базовый
FROM node:18

# Установите директорию для приложения
WORKDIR /app

# Копируйте package.json и package-lock.json
COPY package*.json ./

# Установите зависимости
RUN npm install

# Копируйте исходный код приложения в контейнер
COPY . .

# Откройте порт
EXPOSE 3000

# Определите команду для запуска приложения
CMD ["npm", "start"]