import React from 'react'
import { TouchableOpacity, View, Text, Image, StyleSheet } from 'react-native'
import { getImageFromApiByName } from '../API/TMDB_API';

class FilmItem extends React.Component {
    render() {
        const { film, displayDetailOfFilm } = this.props;
        return (
            <TouchableOpacity
                style={ styles.main }
                onPress={ () => displayDetailOfFilm(film.id) }
                >
                <Image style={ styles.image } source={ { uri: getImageFromApiByName(film.poster_path) } }/>
                <View style={ styles.text }>
                    <View style={ styles.header }>
                        <Text style={ styles.title }>
                            { film.title }
                        </Text>
                        <Text style={ styles.vote }>
                            { film.vote_average }
                        </Text>
                    </View>
                    <Text style={ styles.description } numberOfLines={ 6 }>
                        { film.overview }
                    </Text>
                    <Text style={ styles.date }>
                        Sorti le { film.release_date }
                    </Text>
                </View>
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    main: {
        flex: 1,
        flexDirection: 'row',
        margin: 2,
        backgroundColor: 'whitesmoke'
    },
    image: {
        width: 120,
        height: 180,
        margin: 2
    },
    text: {
        flex: 2,
        flexDirection: 'column',
        margin: 2
    },
    header: {
        flex: 1,
        flexDirection: 'row',
        margin: 2
    },
    title: {
        flex: 4,
        flexWrap: 'wrap',
        fontSize: 20,
        fontWeight: 'bold'
    },
    vote: {
        flex: 1,
        textAlign: 'center',
        color: 'grey',
        fontSize: 24,
        fontWeight: 'bold'
    },
    description: {
        flex: 4,
        margin: 2,
        color: 'grey',
        fontStyle: 'italic'
    },
    date: {
        flex: 1,
        textAlign: 'right',
        margin: 2
    },
});

export default FilmItem