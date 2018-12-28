// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'
const time = 60 * 3
const interval = 100

export default class Typing extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      target: '',
      mean: '',
      char_index: 0,
      word_index: 0,
      isLive: false,
      score: 0,
      sec: 0,
      timer: null
    }
    this.timerId = 0
    this.start = this.start.bind(this)
    this.handleKeyUp = this.handleKeyUp.bind(this)

    axios.get('/texts')
      .then((result) => {
        this.setState({
          words: result.data
        })
      })
      .catch((data) => {
        console.error(data)
      })
  }

  componentWillMount () {
    document.addEventListener('keyup', (e) => { this.handleKeyUp(e) })
    this.setState({
      csrf: document.getElementsByName('csrf-token').item(0).content
    })
  }

  tick () {
    let sec = this.state.sec - 1
    this.setState({
      sec: sec
    })

    if (this.state.sec <= 0) {
      this.finish()
    }
  }

  nextText () {
    const idx = this.state.word_index + 1
    if (idx === this.state.words.length) {
      this.finish()
    }

    this.setState({
      target: this.state.words[idx].word,
      mean: this.state.words[idx].mean,
      char_index: 0,
      word_index: idx
    })
  }

  isCorrectKey (key) {
    const idx = this.state.char_index
    const chr = this.state.target[idx]

    if (chr === key) {
      return true
    } else {
      return false
    }
  }

  start () {
    if (this.state.isLive) {
      return
    }
    const idx = 0
    this.setState({
      target: this.state.words[idx].word,
      mean: this.state.words[idx].mean,
      score: 0,
      char_index: 0,
      word_index: 0,
      sec: time,
      isLive: true
    })

    this.timerId = setInterval((e) => {
      this.tick()
    }, interval)
  }

  stop () {
    this.setState({
      target: '',
      mean: '',
      char_index: 0,
      isLive: false,
      score: 0,
      timer: null
    })

    clearInterval(this.timerId)
  }

  handleKeyUp (e) {
    if (!this.state.isLive) {
      return
    }

    if (this.isCorrectKey(e.key)) {
      let idx = this.state.char_index + 1

      this.setState({
        char_index: idx
      })

      if (this.state.char_index >= this.state.target.length) {
        const score = this.state.score + 1
        this.setState({
          score: score
        })
        this.nextText()
      }
    }
  }

  finish () {
    clearInterval(this.timerId)
    this.setState({
      target: '',
      mean: '',
      isLive: false
    })
    this.result()
  }

  result () {
    const score = this.state.score
    const point = ((score / this.state.words.length) * 100).toFixed(2)

    axios.defaults.headers.common['X-CSRF-Token'] = this.state.csrf
    axios.post('/scores', {
      score: {
        point: point
      }})
      .then((result) => {
        console.log(result)
      })
      .catch((data) => {
        console.error(data)
      })
  }

  targetWord () {
    const tmp = this.state.target.split('').map((v, i) => {
      if (i < this.state.char_index) {
        return '_'
      } else {
        return v
      }
    })

    return tmp.join('')
  }

  render () {
    return (
      <div className='typing' onClick={this.start}>
        <div className='target hide-cursor'>{this.targetWord()}</div>
        <div className='target'>
          {this.state.isLive ? '' : 'click to start' }
        </div>
        <div className='info'>
          <div>Mean: {this.state.mean}</div>
          <div>Letters count: {this.state.score}</div>
          <div>Remining Time: {this.state.sec}</div>
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Typing />, document.getElementById('typing'))
})
