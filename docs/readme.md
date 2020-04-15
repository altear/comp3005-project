# COMP3005 Project Report

Andre Telfer
100880651



## Contents

[TOC]

## 1. Problem Statement

We are designing a bookstore. 



## 2. Project Report

### 2.1. Conceptual Design

![](C:\Users\Owner\Documents\repos\comp3005-project\docs\ER diagram.png)



### 2.2. Reduction to Relation Schema

![](relation_schema.png)

### 2.3. Normalization of Relation Schemas

We used Third Normal Form (3NF)

#### book


$$
\begin{align}
\text{let }A &= ISBN\\
\text{let }B &= title\\
\text{let }C &= author\\
\text{let }D &= genre\\
\text{let }E &= price\\
\text{let }F &= pages\\
\\
R &= (A, B, C, D, E, F, E, F) \\
\\
F &= \{ \\&A \rightarrow B, A \rightarrow C, A \rightarrow D, 
\\&A \rightarrow E, A \rightarrow F \\\} \\
\\

&& result &= A \\
\\
A &\rightarrow B &result &= AB \\
A &\rightarrow C &result &= ABC \\
A &\rightarrow D &result &= ABCD \\
A &\rightarrow E &result &= ABCDE \\
A &\rightarrow F &result &= ABCDEF \\
\end{align} \\
$$
Therefore ISBN is a superkey and this relation is in 3NF form

#### publisher

$$
\begin{align}
\text{let }A &= ID\\
\text{let }B &= name\\
\text{let }C &= holder\_name\\
\text{let }D &= financial\_institute\\
\text{let }E &= branch\_number\\
\text{let }F &= transit\_number\\
\text{let }G &= account\_number\\
\\
R &= (A, B, C, D, E, F, E, F, G) \\
\\
F &= \{ \\&A \rightarrow B, A \rightarrow C, A \rightarrow D, 
\\&A \rightarrow E, A \rightarrow F, A \rightarrow G \\\}
\\

&& result &= A \\
\\
A &\rightarrow B &result &= AB \\
A &\rightarrow C &result &= ABC \\
A &\rightarrow D &result &= ABCD \\
A &\rightarrow E &result &= ABCDE \\
A &\rightarrow F &result &= ABCDEF \\
A &\rightarrow G &result &= ABCDEFG \\
\end{align} \\
$$



Therefore ID is a superkey and this relation is in 3NF form

#### contact_info

$$
\begin{align}
\text{let }A &= ID\\
\text{let }B &= address_id\\
\text{let }C &= email\\
\text{let }D &= phone_number\\
\\
R &= (A, B, C, D) \\
\\
F &= \{ \\&A \rightarrow B, A \rightarrow C, A \rightarrow D\\\} \\
\\

&& result &= A \\
\\
A &\rightarrow B &result &= AB \\
A &\rightarrow C &result &= ABC \\
A &\rightarrow D &result &= ABCD \\
\end{align} \\
$$

Therefore ID is a superkey and this relation is in 3NF form

#### Simple cases

1. The following relations have only two attributes and one functional dependency connecting them, giving a clear primary key showing that they are in 3NF form

   They can be tested with the following form

$$
\begin{align}
R &= AB \\
F &= \{A \rightarrow B\}\\
\\
&&& result = A \\
A &\rightarrow B && result=AB \\
\end{align}
$$

$\therefore$ for every functional dependency $\alpha\rightarrow \beta$ in $F_c$, $\alpha$ is a superkey

- user
- user_contact
- order_cart
- user_order
- pub_contact
- contact_address
- preferred_payment
- warehouse_address
- shipping_address
- stock



2. Another simple case are entities with one attribute 

- cart
- warehouse

...

### 2.4. Database Schema Diagram

I collapsed some of the 1-1 relations into the stronger entity (whichever one seemed like it would be used more) 

![](C:\Users\Owner\Documents\repos\comp3005-project\docs\final_relational_schema.png)

### 2.5. Implementation

#### Tech Stack

- Docker Compose: used to create database and server instances
  - Postgres Image: the main database
  - Redis: used for storing temporary sessions
  - Flask (Python): The backend framework
  - React: The frontend framework
  - Nginx

#### Store View

![1586910787226](C:\Users\Owner\AppData\Roaming\Typora\typora-user-images\1586910787226.png)

#### Login

![1586910809431](C:\Users\Owner\AppData\Roaming\Typora\typora-user-images\1586910809431.png)

I have the structure for creating APIs, user authentication (as well as permissions) that are working well with some simple session logic. Queries are fetched, data is sent. The basic pieces are there, unfortunately the higher level parts of the project are noticeably absent, I ran out of time. 

- honestly I don't think I could've done better unless I had a group, it's been crazy and I'm so burnt out. Setting up the environment was a ton of work on its own.


### 2.7 Github Repository
GitHub Repository:
<https://github.com/altear/comp3005-project>


### 2.8 Appendix I
I filled out the poll, but anytime works. It should be a short presentation.


