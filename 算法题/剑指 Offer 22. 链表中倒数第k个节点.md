```js
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} k
 * @return {ListNode}
 */
var getKthFromEnd = function(head, k) {
    let fast = head, slow = head; //快慢指针

    while(fast && k--){ //快指针先走k次,这样快慢指针之间相距k个节点
        fast = fast.next;
    }

    //当快指针走到链表尾时,慢指针正好指向倒数第k个节点
    while(fast){
        fast = fast.next;
        slow = slow.next;
    }
    return slow;
};
```

