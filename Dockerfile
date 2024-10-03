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

   # Компилируем проект
   RUN npm run build

   # Экспонируем нужный порт
   EXPOSE 8080

   # Запускаем приложение Vite
   CMD ["npm", "run", "dev"]