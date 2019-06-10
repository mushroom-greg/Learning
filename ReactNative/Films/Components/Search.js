import React from 'react'
import { Button, FlatList, StyleSheet, TextInput, View, ActivityIndicator } from 'react-native'
import FilmItem from './FilmItem'
import { getFilmsFromApiByName } from '../API/TMDB_API';

class Search extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            films: [],
            isLoading: false
        };
        this.searchText = "";
        this.page = 0;
        this.totalPages = 0;
    }

    _changeSearchText(text) {
        this.searchText = text;
    }

    _searchFilms() {
        this.page = 0;
        this.totalPages = 0;
        this.setState({
                films: []
            });
        this._loadFilms();
    }

    _loadFilms() {
        if (this.searchText.length > 0)
            this.setState({ isLoading: true });
            getFilmsFromApiByName(this.searchText, this.page + 1)
                .then(data => {
                    this.page = data.page;
                    this.totalPages = data.total_pages;
                    this.setState({
                        isLoading: false,
                        films: [ ...this.state.films, ...data.results ]
                    });
                    //this.__debug();
                });
    }

    _loadFilmsOnEndList() {
        if (this.state.films.length > 0 && this.page < this.totalPages)
            this._loadFilms();
    }

    _displayDetailOfFilm = (id) => {
        console.log('Display film with id ' + id);
        this.props.navigation.navigate('FilmDetail', { id: id });
    };

    _displayLoading() {
        if (this.state.isLoading)
            return (
                <View style={ styles.loading }>
                    <ActivityIndicator size={ 'large' }/>
                </View>
            )
    }

//    __debug() {
//        for (let film of this.state.films) {
//            console.log(film.title);
//        }
//        console.log(this.state.films.length);
//    }

    render() {
        return (
            <View style={ styles.main }>
                <View style={ styles.search }>
                    <TextInput
                        style={ styles.input }
                        placeholder={'Quel film souhaitez vous consulter ?'}
                        onChangeText={(text) => this._changeSearchText(text)}
                        onSubmitEditing={() => this._searchFilms()}
                    />
                    <Button
                        style={ styles.button }
                        title={'Rechercher'}
                        onPress={() => this._searchFilms()}
                    />
                </View>
                <FlatList
                    style={ styles.list }
                    data={ this.state.films }
                    keyExtractor={(item) => item.id.toString()}
                    renderItem={({item}) => <FilmItem film={item} displayDetailOfFilm={this._displayDetailOfFilm}/>}
                />
                { this._displayLoading() }
            </View>
        )
    }
}

const styles = StyleSheet.create({
    main: {
        height: '100%',
        marginLeft: '5%',
        marginRight: '5%'
    },
    search: {
        height: '15%',
    },
    input: {
        height: '50%',
        padding: '2%',
        textAlign: 'center'
    },
    button: {
        height: '50%',
        padding: '2%'
    },
    list: {
        height: 'auto'
    },
    loading: {
        position: 'absolute',
        left: 0,
        right: 0,
        top: 100,
        bottom: 0,
        alignItems: 'center',
        justifyContent: 'center'
    },
    footer: {
        height: '5%'
    }
});

export default Search