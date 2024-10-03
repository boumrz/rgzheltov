   # Базовый образ
   FROM node:18-alpine

   # Устанавливаем рабочую директорию
   WORKDIR /app

   # Копируем package.json и pnpm-lock.yaml (если используется) и только потом устанавливаем зависимости
   COPY package.json package-lock.json* ./

   # Устанавливаем зависимости
   RUN npm install

   # Копируем все файлы в контейнер
   COPY . .

   RUN npm start

   EXPOSE 10000
