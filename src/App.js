import React from 'react';
import logo from './logo.svg';
import './App.css';
import Nav from './components/Nav';
import List from './components/List';
import Note from './components/Note';
import axios from 'axios';
import urlFor from './helpers/urlFor';

class App extends React.Component {
  constructor() {
    super();
    this.state = {
      showNote: false
    };
  }

  toggleNote = () => {
    this.setState({
      showNote: ! this.state.showNote
    });
  }

  getNotes = () => {
    axios.get(urlFor('notes'))
      .then((res) => console.log(res.data) )
      .catch((err) => console.log(err.response.data) );
  }
  render() {
    const { showNote} = this.state;
    return (
      <div className="App">
        <Nav toggleNote={this.toggleNote} showNote={showNote}/>
        { showNote ? <Note /> : <List getNotes={this.getNotes}/> }
      </div>
    );
  }
}

export default App;
