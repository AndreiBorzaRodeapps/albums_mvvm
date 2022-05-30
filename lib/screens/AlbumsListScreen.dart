import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import '../DUMMY_DATA.dart';
import 'package:albums_mvvm/view_models/album_viewmodel.dart';
import '../screens/NoInternetScreen.dart';

class AlbumsListScreen extends StatelessWidget {
  static const routeName = '/albums_list';

  // final _data = DUMMY_DATA();
  final viewModel = Album_ViewModel();

  @override
  Widget build(BuildContext context) {
    return MainMenu();
  }
}

class MainMenu extends StatelessWidget {
  final viewModel = Album_ViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: viewModel.fetchAlbums(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).bottomAppBarColor),
            )
          : Container(
              width: double.infinity,
              height: 635,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (item, idx) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.5, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                    ),
                                    Icon(
                                      Icons.list_alt_sharp,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  subtitle: Text(
                                      'Album with id: ${snapshot.data[idx].id}'),
                                  onTap: null,
                                  // in caz ca se poate merge la details doar de pe sageata
                                  title: Text(
                                    overflow: TextOverflow.ellipsis,
                                    snapshot.data[idx].title as String,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chevron_right),
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
