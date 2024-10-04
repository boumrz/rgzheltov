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

# Используем nginx для обслуживания статических файлов
FROM nginx:alpine AS nginx

# Копируем скомпилированные файлы в папку, обслуживаемую nginx
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Экспонируем нужный порт
EXPOSE 80

# Дефолтная команда, которая будет выполняться при запуске контейнера nginx
CMD ["nginx", "-g", "daemon off;"]