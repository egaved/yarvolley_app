const app = require('./app');
const http = require('http');

// Настройка порта [[6]]
const PORT = process.env.PORT || 3000;

// Создание HTTP-сервера [[8]]
const server = http.createServer(app);

// Запуск сервера
server.listen(PORT, () => {
  console.log(`Сервер запущен на порту ${PORT}`);
});

// Обработка ошибок сервера
server.on('error', (error) => {
  console.error(`Ошибка сервера: ${error.message}`);
});