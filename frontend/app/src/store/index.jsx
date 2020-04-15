import React, { Component } from 'react'
import Table from 'react-bootstrap/Table'

export class Store extends Component {
    constructor (props) {
        super(props)

        this.state = {
            books: []
        }

        this.get_books()
    }

    get_books () {
        fetch('/api/books', {
            method: 'GET'
        })
        .then(resp=>resp.json())
        .then(data=>{
            if (data) {
                this.setState({books: data.books})
                console.log('got books')
            } else {
                console.log('did not get books :(')
            }
        })
    }

    render_books() {
        let books = this.state.books.map((book)=>{
            return <tr key={book.ISBN}> 
                <td>{book.title}</td> 
                <td>{book.author}</td> 
                <td>{book.pages}</td> 
                <td>{book.publisher}</td> 
                <td>{book.price}</td> 
            </tr>
        })
        return <Table striped bordered hover>
            <thead>
                <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Pages</th>
                <th>Publisher</th>
                <th>Price</th>
                </tr>
            </thead>
            <tbody>
                {books}
            </tbody>
        </Table>
    }
    render() {
        return (
            <div>
                <h2>Store</h2>
                {this.render_books()}
            </div>
        )
    }
}

export default Store
