# Базовый образ
FROM node:18-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и pnpm-lock.yaml (если используется) и устанавливаем зависимости
COPY package.json package-lock.json* ./
RUN npm install

# Копируем все файлы в контейнер
COPY . .

# Компилируем проект (предполагается, что это фронтенд)
RUN npm run build

# Теперь создаём образ для сервера
FROM node:18-alpine AS server

# Устанавливаем рабочую директорию для сервера
WORKDIR /app/server

# Копируем package.json и устанавливаем зависимости сервера
COPY server/package.json server/package-lock.json* ./
RUN npm install

# Копируем скомпилированные файлы фронтенда из образа builder
COPY --from=builder /app/dist ./public

# Копируем файлы сервера
COPY server/ ./

# Экспонируем нужный порт (для сервера)
EXPOSE 3000

# Дефолтная команда для запуска сервера
CMD ["node", "index.js"]  # замените index.js на ваш основной файл сервера

# Используем nginx для обслуживания статических файлов
FROM nginx:alpine AS nginx

# Копируем скомпилированные файлы в папку, обслуживаемую nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Экспонируем нужный порт
EXPOSE 80

# Дефолтная команда, которая будет выполняться при запуске контейнера nginx
CMD ["nginx", "-g", "daemon off;"]