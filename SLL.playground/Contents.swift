import UIKit

var array1 = [2,9,0,6,8,10]
var array2 = [10,4,7]
var sortedArray1 = [2,8,10,15]
var sortedArray2 = [4,7,12,16,17,18]
var duplicateArray1 = [1,3,5,5,7,9,9,9]

public class LinkedListNode<T>  {

    public var data: T
    public var next: LinkedListNode?

    public init(data: T, next: LinkedListNode? = nil) {
        self.data = data
        self.next = next
    }
}

public struct SingleLinkedList<T>  {
    
    var headNode: LinkedListNode<T>?
    var tailNode: LinkedListNode<T>?
    
    public init() {}
    
    // To check linked list is empty or not
    
    public var isEmpty: Bool {
        headNode == nil
    }
    
    // To count total number of nodes
    
    public var count: Int {
        guard var headNode = self.headNode else {
            return 0
        }
        var count = 1
        var firstIndex = 0
        while(headNode.next != nil) {
            count += 1
            headNode = headNode.next!
            firstIndex += 1
        }
        return count
    }
    
    // To check list is sorted or not
    
    public var isSorted: Bool {
        guard var node = self.headNode else {
            return false
        }
        var minimum = 0
        var firstIndex = 0
        while(firstIndex < self.count) {
            if let data = node.data as? Int {
                if minimum > data {
                    return false
                }
                minimum = node.data as! Int
                if let next = node.next {
                    node = next
                }
            }
            firstIndex += 1
        }
        return true
    }
    
    /* 1. push: Adds a value at the front of the list. */
    
    public mutating func push(_ value: T) {
        headNode =  LinkedListNode(data: value, next: headNode)
        if tailNode == nil {
            tailNode = headNode
        }
    }
    
    /* 2. append: Adds a value at the end of the list. */
    
    public mutating func append(_ value: T) {
        if isEmpty {
            push(value)
        } else {
            let newNode = LinkedListNode(data: value, next: nil)
            tailNode?.next = newNode
            tailNode = tailNode?.next
        }
    }
    
    /* 3. display: Display the list from head to tail node. */
    
    public mutating func display() {
        var node = self.headNode
        while(node != nil) {
            print(node?.data as Any)
            node = node?.next
        }
    }
    
    /* 4. max: Maximum element in a list */
    
    public mutating func max() -> T {
        var node = self.headNode
        var maximum = 0
        while(node != nil) {
            if let nnode = node, let data = nnode.data as? Int {
                if maximum < data {
                    maximum = data
                }
                node = node?.next
            }
        }
        return maximum as! T
    }
    
    /* 5. sum: Sum of element in a list */
    
    public mutating func sum() -> T {
        var node = self.headNode
        var sum = 0
        while(node != nil) {
            if let nnode = node, let data = nnode.data as? Int {
                sum += data
            }
            node = node?.next
        }
        return sum as! T
    }
    
    /* 6. linearSearch: Search element in a list */
    
    public mutating func linearSearch(value: Int) -> LinkedListNode<T>? {
        var node = self.headNode
        while(node != nil) {
            if let nnode = node, let data = nnode.data as? Int, data == value {
                return node
            }
            node = node?.next
        }
        return nil
    }
    
    /* 7. insertAtFirst: Insert value before first position in a list */
    
    public mutating func insertAtFirst(value: T) {
        let newNode = LinkedListNode(data: value, next: self.headNode)
        self.headNode = newNode
    }
    
    /* 8. insert: Insert value at particular position in a list */
    
    public mutating func insert(value: T, index: Int) {
        var firstIndex = 0
        var node = self.headNode
        while (firstIndex < index) {
            node = node?.next
            firstIndex += 1
        }
        let newNode = LinkedListNode(data: value, next: node?.next)
        node?.next = newNode
    }
    
    /* 9. insertAtLast: Insert value after last position in a list */
    
    public mutating func insertAtLast(value: T) {
        if self.tailNode == nil {
            headNode =  LinkedListNode(data: value, next: headNode)
            tailNode = headNode
        } else {
            let newNode = LinkedListNode(data: value, next: nil)
            self.tailNode?.next = newNode
        }
    }
    
    /* 10. deleteAtFirst: Delete first value */
    
    public mutating func deleteAtFirst() {
        guard self.headNode != nil else { return }
        var newHeadNode = self.headNode?.next
        headNode = newHeadNode
        newHeadNode = nil
    }
    
    /* 11. delete: Delete value at particular position in a list */
    
    public mutating func delete(index: Int) {
        guard self.headNode != nil else { return }
        var firstIndex = 0
        var node = self.headNode
        var tempNode: LinkedListNode<T>?
        while (firstIndex < index) {
            tempNode = node
            node = node?.next
            firstIndex += 1
        }
        tempNode?.next = node?.next
        node = nil
    }
    
    /* 12. removeDuplicate: Remove duplicate element in a list */
    
    public mutating func removeDuplicate() {
        guard var node = self.headNode else { return }
        var secondNode = self.headNode?.next
        while(node.next != nil) {
            if node.data as? Int ?? 0 == secondNode?.data as? Int ?? 0 {
                node.next = secondNode?.next
                secondNode = nil
                secondNode = node.next
            } else {
                node = secondNode!
                secondNode = secondNode?.next
            }
        }
    }
    
    /* 13. reverse: Reverse list */
    
    public mutating func reverse() {
        guard self.headNode != nil else { return }
        var node = self.headNode
        var prevNode: LinkedListNode<T>?
        var prevToPrevNode: LinkedListNode<T>?
        while(node != nil) {
            prevToPrevNode = prevNode
            prevNode = node
            node = node?.next
            prevNode?.next = prevToPrevNode
        }
        self.headNode = prevNode
    }
    
    /* 14. concat: Concat two list */
    
    public mutating func concat(list: SingleLinkedList<T>) {
        var node = self.headNode
        var firstIndex = 0
        let count = self.count
        while(firstIndex < count - 1) {
            node = node?.next
            firstIndex += 1
        }
        node?.next = list.headNode
        self.tailNode = list.tailNode
    }
    
    /* 14. mergeTwoSortedList: Merge two sorted list */
    
    public mutating func mergeTwoSortedList(list: SingleLinkedList<T>) {
        let newHeadNode = LinkedListNode(data: 0 as! T, next: nil)
        var currentNode = newHeadNode
        var firstNode = self.headNode
        var secondNode = list.headNode
        while firstNode != nil && secondNode != nil {
            if firstNode?.data as? Int ?? 0 < secondNode?.data as? Int ?? 0 {
                currentNode.next = firstNode
                firstNode = firstNode?.next
            } else {
                currentNode.next = secondNode
                secondNode = secondNode?.next
            }
            currentNode = currentNode.next!
        }
        currentNode.next = firstNode ?? secondNode
        self.headNode = newHeadNode.next
    }
}

/* Create and fetch linked list */

func createAndFetchLinkedList(array: inout [Int]) -> SingleLinkedList<Int> {
    var firstIndex = 0
    let lastIndex = array.count
    var list = SingleLinkedList<Int>()
    while (firstIndex < lastIndex) {
        list.append(array[firstIndex])
        firstIndex += 1
    }
    return list
}

var list1 = createAndFetchLinkedList(array: &array1)
var list2 = createAndFetchLinkedList(array: &duplicateArray1)
let list3 = createAndFetchLinkedList(array: &array2)
var list4 = createAndFetchLinkedList(array: &sortedArray1)
let list5 = createAndFetchLinkedList(array: &sortedArray2)

//print("List elements are", list1.display())
//print("List is sorted", list1.isSorted)
//print("Sum of elements are", list1.sum())
//print("Max of elements is", list1.max())
//print("Linear search is", list1.linearSearch(value: 10) as Any)
//print("Insert at first positon", list1.insertAtFirst(value: 55), list1.display())
//print("Insert at positon", list1.insert(value: 35, index: 3), list1.display())
//print("Insert at positon", list1.insertAtLast(value: 6), list1.display())
//print("Delete at first positon", list1.deleteAtFirst(), list1.display())
//print("Delete at positon", list1.delete(index: 2), list1.display())
//print("List of elements after removing duplicates are", list2.removeDuplicate(), list2.display())
//print("List of elements after reversed are", list1.reverse(), list1.display())
//print("List of elements after concat are", list1.concat(list: list3), list1.display())
//print("List of elements after merge are", list4.mergeTwoSortedList(list: list5), list4.display())


/* Sum of element of linked list */

func sumOfElement(_ head: SingleLinkedList<Int>) {
    var headOfNode: LinkedListNode<Int>? = head.headNode
    var sum = 0
    while(headOfNode != nil) {
        if let data = headOfNode?.data {
            sum += data
        }
        headOfNode = headOfNode?.next
    }
    print("Sum of linked list elements are", sum)
}

//sumOfElement(createAndFetchLinkedList(array: &array1))


