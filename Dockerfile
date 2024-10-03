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

   # Используем nginx для обслуживания статических файлов
   FROM nginx:alpine

   # Копируем скомпилированные файлы в папку, обслуживаемую nginx
   COPY --from=0 /app/dist /usr/share/nginx/html

   # Экспонируем нужный порт
   EXPOSE 8080

   # Дефолтная команда, которая будет выполняться при запуске контейнера
   CMD ["nginx", "-g", "daemon off;"]