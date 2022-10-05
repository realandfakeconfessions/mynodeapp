const axios = require('axios');

async function makeRequest() {

    const config = {
        method: 'get',
        url: 'http://localhost:8090/read/all'
    }

    let res = await axios(config)

    console.log(res.data);
}

setInterval(makeRequest, 60000);
