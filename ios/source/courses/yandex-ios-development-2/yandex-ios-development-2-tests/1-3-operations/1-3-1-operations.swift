// Operation
// Одна задача
// Абстрактный класс
// Состояния
// Приоритет
// Зависимости

// Operation live cycle:
// -> Pending -> Ready -> Executing -> Finished

// Possible moves:
// -> Pending -> Cancelled
// -> Ready -> Cancelled
// -> Executing -> Cancelled

// Statuses:
// -> Pending - ожидание зависимостей
// -> Ready - ожидание когда очередь освободится, и возьмет операцию на выполнение
// -> Executing - выполнение
// -> Finished - выполнена
