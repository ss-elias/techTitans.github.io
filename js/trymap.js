const options = {method: 'GET'};

fetch('https://ipgeolocation.abstractapi.com/v1', options)
  .then(response => response.json())
  .then(response => console.log(response))
  .catch(err => console.error(err));