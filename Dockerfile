# Используйте официальный Node.js образ как базовый
FROM node:18

# Установите директорию для приложения
WORKDIR front

# Копируйте package.json и package-lock.json
COPY package*.json ./front

# Установите зависимости
RUN npm install

# Копируйте исходный код приложения в контейнер
COPY . /front

# Откройте порт
EXPOSE 5173

# Определите команду для запуска приложения
CMD ["npm", "start"]