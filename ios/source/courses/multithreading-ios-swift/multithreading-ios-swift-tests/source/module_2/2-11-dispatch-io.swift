// 2-11-dispatch-io

import Foundation

// DispatchIO - API для взаимодействия с файловой системой

struct DispatchIOData: Codable {
    let id: String
}

class GcdChannelTest {
    private let concurrentQueue = DispatchQueue(
        label: "com.concurrentQueue",
        attributes: .concurrent
    )

    private var channel: DispatchIO?

    func test() {
        guard
            let filePath = Bundle.main.path(
                forResource: "dispatch-io",
                ofType: "json"
            ) else {
            print("Path for resource unavailable")
            return
        }

        channel = DispatchIO(
            type: DispatchIO.StreamType.stream,
            path: filePath,
            oflag: O_RDONLY,
            mode: 0,
            queue: DispatchQueue.global(),
            cleanupHandler: { error in
                // handle error
                print("Got error DispatchIO.init(): \(error)")
            })

        channel?.read(
            offset: 0,
            length: Int.max,
            queue: concurrentQueue,
            ioHandler: { (done, data, error) in
                if error != 0 {
                    // handle error
                    print("Got error in channel?.read: \(error)")
                }
                if let data = data {
                    // handle data
                    print("Got data in channel?.read: \(data)")

                    guard let data = data as AnyObject as? Data else {
                        print("Couldn't get `Data` from `DispatchData`")
                        return
                    }

                    do {
                        let dispatchIOData = try JSONDecoder()
                            .decode(DispatchIOData.self, from: data)
                        print("Got DispatchIOData: \(dispatchIOData)")
                    } catch {
                        print("Couldn't get DispatchIOData from data with error: \(error)")
                    }
                }
            })
    }
}

let gcdChannelTest = GcdChannelTest()
gcdChannelTest.test()
