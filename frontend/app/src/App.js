
import React, { Component } from 'react'
import logo from './logo.svg';
import './App.css';

import 'bootstrap/dist/css/bootstrap.min.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  Redirect
} from "react-router-dom";
import { Login } from './login';
import history from './history';
import Store from './store';
import Navbar from 'react-bootstrap/Navbar'
import Nav from 'react-bootstrap/Nav'
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'

export class PrivateRoute extends Component {
  render() {
    return (
      <Route
        render={({ location }) =>
          this.props.auth.isAuthenticated ? (
            this.props.children
          ) : (
              <Redirect
                to={{
                  pathname: "/login",
                  state: { from: location }
                }}
              />
            )
        }
      />
    );
  }
}


export class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isAuthenticated: false,
      session: null

    }
  }

  authenticate(username, password) {
    fetch("/api/login", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username: username, password: password
      })
    })
      .then(resp => resp.json())
      .then(data => {
        if (!data.auth) {
          alert("Login failed, please try again")
          return
        }
        this.setState({
          isAuthenticated: data.auth,
          session: data.session
        })
        history.push("/")
      })
  }

  logout() {
    fetch("/api/logout", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ session: this.session })
    }).then(resp => {
      if (resp.status == 200) {
        history.push("/login")
        this.setState({
          session: null,
          isAuthenticated: false
        })
      }
    })
  }

  render() {
    let loginout = this.state.isAuthenticated ?
      (<Nav.Link as={Link} to="/logout">Logout</Nav.Link>) :
      (<Nav.Link as={Link} to="/login"> Login </Nav.Link>);

    return (
      <Router history={history} >
        <div>
          <Navbar bg="primary" variant="dark">
            <Navbar.Brand href="#home">Navbar</Navbar.Brand>
            <Nav className="mr-auto">
              <Nav.Link as={Link} to="/">Books</Nav.Link>
              <Nav.Link as={Link} to="/cart">Cart</Nav.Link>
              <Nav.Link as={Link} to="/orders">Orders</Nav.Link>
            </Nav>
            <Nav>
              {loginout}
            </Nav>
          </Navbar>
          <Container fluid='md' style={{paddingTop: '40px'}}>
            <Row>
              <Col>
                <Switch>
                  <Route exact path="/login">
                    <Login auth_callback={this.authenticate.bind(this)} auth={this.state} />
                  </Route>
                  <Route exact path="/" auth={this.state}>
                    <Store />
                  </Route>
                  <Route path="/store" auth={this.state}>
                    <Store />
                  </Route>
                  <PrivateRoute path="/cart" auth={this.state}>
                    <Cart />
                  </PrivateRoute>
                  <PrivateRoute path="/orders" auth={this.state}>
                    <Orders />
                  </PrivateRoute>
                  <PrivateRoute exact path="/logout" auth={this.state}>
                    <Logout logout={this.logout.bind(this)} />
                  </PrivateRoute>

                </Switch>
              </Col>
            </Row>
          </Container>
        </div>
      </Router >
    )
  }
}

function Cart() {
  return <h2>Cart</h2>;
}

function Orders() {
  return <h2>Orders</h2>;
}

function Logout(props) {
  console.log("LOGOUT!")
  props.logout()
  return (<div></div>) //<Redirect to="/login"></Redirect>
}

export default App;
