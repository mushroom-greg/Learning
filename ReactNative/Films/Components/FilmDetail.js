import React from 'react'
import { StyleSheet, View, Text } from 'react-native'
import { getFilmDetailFromApiById } from '../API/TMDB_API';

class FilmDetail extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            film: undefined,
            isLoading: true
        }
    }

    componentDidMount() {
        getFilmDetailFromApiById(this.props.navigation.state.params.id)
            .then(data => {
                this.setState({
                    film: data,
                    isLoading: false
                })
            })
    }

    _displayLoading() {
        if (this.state.isLoading) {
            return (
                <ScrollView style={ styles.loading_container }>
                    <ActivityIndicator size='large' />
                </ScrollView>
            )
        }
    }

    _displayFilm() {
        if (this.state.film != undefined) {
            return (
                <ScrollView style={styles.scrollview_container}>
                    <Text>{this.state.film.title}</Text>
                    {}
                </ScrollView>
            )
        }
    }

    render() {
        return (
            <View style={styles.main_container}>
                <View style={styles.main_container}>
                    {this._displayLoading()}
                    {this._displayFilm()}
                </View>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    main_container: {
        flex: 1,
    },
    loading_container: {
        position: 'absolute',
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        alignItems: 'center',
        justifyContent: 'center'
    }
});

export default FilmDetail