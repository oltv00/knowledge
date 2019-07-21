// 1-3-qos

import Foundation

// QoS
// userInteractive - выполнение анимации, или обновление интерфейса
// userInitiated - сохранение документа, выполнение действия по клику пользователя
// utility - загрузка данных
// background - задачи которые не видны пользователю, синхранизация, backup
// default - между userInitiated и utility

// pthread

class PthreadQosTest {
    func test() {
        var thread = pthread_t(bitPattern: 0)
        var attr = pthread_attr_t()
        pthread_attr_init(&attr)
        pthread_attr_set_qos_class_np(&attr, QOS_CLASS_USER_INITIATED, 0)
        pthread_create(&thread, &attr, { pointer in

            print("pthread test")
            pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)

            return nil
        }, nil)
    }
}

let pthread = PthreadQosTest()
pthread.test()

// Thread

class ThreadQosTest {
    func test() {
        let thread = Thread {
            print("thread test")
            print(qos_class_self())
        }
        thread.qualityOfService = .userInteractive
        thread.start()

        print(qos_class_main())
    }
}

let thread = ThreadQosTest()
thread.test()
