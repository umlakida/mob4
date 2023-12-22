import Foundation

let concurrentQueue = OperationQueue()
concurrentQueue.maxConcurrentOperationCount = 1 // Set to 1 for serialization
var accountBalance = 1000

func withdraw(amount: Int) {
    concurrentQueue.addOperation {
        if accountBalance >= amount {
            //Thread.sleep(forTimeInterval: 1)
            accountBalance -= amount
            print("Withdrawal successful. Remaining balance: \(accountBalance)")
        } else {
            print("Insufficient funds")
        }
    }
}

func refillBalance(amount: Int) {
    concurrentQueue.addOperation {
       // Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Refill successful. Remaining balance: \(accountBalance)")
    }
}

for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}
