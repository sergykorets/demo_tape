import React, {Fragment} from 'react';
import axios from 'axios';

export default class SongFinder extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      artist: '',
      phone: '',
      smsStatus: 'initial',
      messages: []
    };
  }

  updateField = (field, value) => {
    this.setState({ [field]: value });
  };

  sendTopTrack = () => {
    axios.post('/song_finder', {artist: this.state.artist, phone: this.state.phone})
      .then(resp => {
        if (resp.data.success) {
          this.setState({smsStatus: 'delivered', messages: resp.data.messages})
        } else {
          this.setState({smsStatus: 'failed', messages: resp.data.messages})
        }
      });
  }

  render() {
    return (
      <div>
        <label htmlFor="artist">
          Artist
        </label>
        <input
          id="artist"
          type="text"
          value={this.state.artist}
          onChange={(e) => this.updateField('artist', e.target.value)}
        />
        <label htmlFor="phone">
          Phone
        </label>
        <input
          id="phone"
          type="text"
          value={this.state.phone}
          onChange={(e) => this.updateField('phone', e.target.value)}
        />
        <button disabled={this.state.artist.length == 0 || this.state.phone.length == 0} onClick={this.sendTopTrack}>Send track</button>
        { this.state.smsStatus === 'delivered' &&
          <Fragment>
            <h1>SMS sent</h1>
            <h3>SMS body text: {this.state.messages[0]}</h3>
          </Fragment>}
        { this.state.smsStatus === 'failed' &&
          <Fragment>
            <h1>SMS delivery failed</h1>
            <h3>Errors:</h3>
            { this.state.messages.map((message, i) =>
              <h4 key={i}>{message}</h4>)}
          </Fragment>}
      </div>
    );
  }
}
