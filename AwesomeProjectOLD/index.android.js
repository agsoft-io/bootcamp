/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  TextInput,
  Image,
  ScrollView,
  ListView,
  View
} from 'react-native';

export default class AwesomeProject extends Component {
  render() {
    return (
      <View style={styles.container}>
        <TextReverser />
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <ScrollView style={styles.list_thin}>
          <Text style={styles.instructions}>
            To get started, edit index.android.js,{'\n'}
            Double tap R on your keyboard to reload,{'\n'}
            Shake or press menu button for dev menu.{'\n'}
            This is my first react native edit
          </Text>
        </ScrollView>
        <ListViewBasics style={styles.list_thin} />
        <Bananas style={styles.image_thin} />
        <BlinkText style={styles.instructions} text='Android' />
        <Greeting style={styles.welcome} name='Bananas' />
      </View>
    );
  }
}

class Bananas extends Component{
  render() {
    let pic = { uri: 'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg' };
    return (
      <Image source={pic} style={this.props.style}/>
    );
  }
}

class Greeting extends Component {
  render() {
    return (
      <Text style={this.props.style}>Hello {this.props.name}!</Text>
    );
  }
}

class BlinkText extends Component {
  constructor(props) {
    super(props);
    this.state = {showText: true};

    // Toggle the state every second
    setInterval(() => {
      //you would use Redux to modify your state rather than calling setState directly.
      this.setState({ showText: !this.state.showText });
    }, 1000);
  }

  render() {
    let display = this.state.showText ? this.props.text : ' ';
    return (
      <Text style={this.props.style}>{display}</Text>
    );
  }
}

class TextReverser extends Component {
  constructor(props) {
    super(props);
    this.state = {text: ''};
  }

  render() {
    return (
      <View style={{padding: 10}}>
        <TextInput
          style={{height: 40}}
          placeholder="Type here to get pizza!"
          onChangeText={(text) => this.setState({text})}
        />
        <Text style={{padding: 10, fontSize: 42}}>
          {this.state.text.split(' ').map((word) => word && '🍕').join(' ')}
        </Text>
      </View>
    );
  }
}

class ListViewBasics extends Component {
  // Initialize the hardcoded data
  constructor(props) {
    super(props);
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
      dataSource: ds.cloneWithRows([
        'John', 'Joel', 'James', 'Jimmy', 'Jackson', 'Jillian', 'Julie', 'Jeremy', 'Devin'
      ])
    };
  }
  render() {
    return (
      <View style={this.props.style}>
        <ListView
          dataSource={this.state.dataSource}
          renderRow={(rowData) => <Text style={{textAlign: 'center'}}>{rowData}</Text>}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'stretch',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    //flex: 1,
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    //flex: 1,
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  image_thin: {
    //flex: 1,
    //width: 250, 
    height: 150,
  },  
  list_thin: {
    flex: 1,
    paddingTop: 22,
  },  
});

AppRegistry.registerComponent('AwesomeProject', () => AwesomeProject);
//AppRegistry.registerComponent('Bananas', () => Bananas);
//AppRegistry.registerComponent('BlinkText', () => BlinkText);
