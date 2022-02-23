const {MerkleTree} = require('merkletreejs')
const SHA256 = require('crypto-js/sha256')

function getMerkleTree(leaf) {
    const leaves = leaf.map(x => SHA256(x))
    const tree = new MerkleTree(leaves, SHA256)
    const root = tree.getRoot().toString('hex')
    console.log(tree.toString())
    console.log(root);
}

getMerkleTree(["Hello", "world"])