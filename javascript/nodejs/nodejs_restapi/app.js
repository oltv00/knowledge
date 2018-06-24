// load our app server using express somehow
const express = require('express')
const app = express()
const morgan = require('morgan')

app.use(morgan('short'))

app.get("/", (req, res) => {
	console.log("Responding to root route")
	res.send("Hello from root")
})

app.get("/users", (req, res) => {
	
	const res_1 = {
		"key_1_1": "value_1_1",
		"key_1_2": "value_1_2"
	}

	const res_2 = {
		"key_2_1": "value_2_1",
		"key_2_2": "value_2_2"
	}

	const response = [res_1, res_2]

	res.json(response)
})

// localhost:3003
app.listen(3003, () => {
	console.log("Server is up and listening on 3003.")
})
