import React, { Component } from 'react'
import { Redirect } from 'react-router-dom';
import Form from 'react-bootstrap/Form'
import Button from 'react-bootstrap/Button'

export class Login extends Component {
    constructor (props) {
        super(props)

        this.state = {
            username: "",
            password: ""
        }
    }

    username_change = (e) => this.setState({username: e.target.value});
    password_change = (e) => this.setState({password: e.target.value});

    handleSubmit = (event) => {
        console.log("Logging in...", this.state.username, this.state.password)   
        this.props.auth_callback(this.state.username, this.state.password)
        event.preventDefault(); // Don't reload
    }

    render() {
        return (
            !this.props.auth.isAuthenticated ? (
                <div>
                    <h2>Login</h2>
                    <Form onSubmit={this.handleSubmit}>
                        <Form.Group >
                            <Form.Label> Username </Form.Label>
                            <Form.Control type="text" placeholder="Enter Username" onChange={this.username_change}></Form.Control>
                        </Form.Group>
                        <Form.Group >
                            <Form.Label> Password </Form.Label>
                            <Form.Control type="password" placeholder="Enter Password"  onChange={this.password_change}></Form.Control>
                        </Form.Group>
                        <Button variant="primary" type="submit">Submit</Button>
                    </Form>
                </div>
            ) : (
                <Redirect to="/"></Redirect>
            )
        )
    }
}


export default Login
