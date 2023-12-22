import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue")
var accountBalance = 1000
let balanceAccessSemaphore = DispatchSemaphore(value: 1)

func withdraw(amount: Int) {
    concurrentQueue.async {
        balanceAccessSemaphore.wait()
        defer { balanceAccessSemaphore.signal() }

        if accountBalance >= amount {
            Thread.sleep(forTimeInterval: 1)
            accountBalance -= amount
            print("Withdrawal successful. Remaining balance: \(accountBalance)")
        } else {
            print("Insufficient funds")
        }
    }
}

func refillBalance(amount: Int) {
    concurrentQueue.async {
        balanceAccessSemaphore.wait()
        defer { balanceAccessSemaphore.signal() }

        Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Refill successful. Remaining balance: \(accountBalance)")
    }
}

for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}
