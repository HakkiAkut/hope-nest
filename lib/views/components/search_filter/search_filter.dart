import 'package:flutter/material.dart';
import 'package:hope_nest/models/search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/blog_vm.dart';
import 'package:hope_nest/views/components/styles/login_input_style.dart';
import 'package:hope_nest/views/components/styles/text_style.dart';
import 'package:provider/provider.dart';

class SearchFilter {
  final _formKey = GlobalKey<FormState>();
  SearchAdvert advert = SearchAdvert();

  searchAdvertDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final _advertVM = Provider.of<AdvertVM>(context);
            final _appUserVM = Provider.of<AppUserVM>(context);
            SearchAdvert _searchAdvert = SearchAdvert();
            print("builder");
            return AlertDialog(
              title: const Text("Advert"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownSearch<String>(
                          showSearchBox: true,
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: const [
                            "Ankara",
                            "Antalya",
                            "Bursa",
                            'Istanbul'
                          ],
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Location",
                          ),
                          onChanged: (value) {
                            _searchAdvert.location = value;
                          },
                          selectedItem:
                              _advertVM.searchAdvert.location == null &&
                                      _advertVM.searchAdvert.location == ""
                                  ? null
                                  : _advertVM.searchAdvert.location),
                      DropdownSearch<String>(
                        showSearchBox: true,
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: const ["Bird", "Dog", "Cat", 'Rabbit', 'Fish'],
                        dropdownSearchDecoration: const InputDecoration(
                          labelText: "Kind",
                        ),
                        onChanged: (value) {
                          _searchAdvert.kind = value;
                        },
                        selectedItem: _advertVM.searchAdvert.kind == null &&
                                _advertVM.searchAdvert.kind == ""
                            ? null
                            : _advertVM.searchAdvert.kind,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _advertVM.searchAdvert = SearchAdvert();
                    Navigator.pop(context);
                    _appUserVM.tec.text = _advertVM.searchAdvert.toString();
                  },
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _advertVM.searchAdvert = _searchAdvert;
                    _appUserVM.tec.text = _advertVM.searchAdvert.toString();
                    Navigator.pop(context);
                  },
                  child: const Text("Search"),
                )
              ],
            );
          },
        );
      },
    );
  }

  searchPostDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final _postVM = Provider.of<BlogVM>(context);
            final _appUserVM = Provider.of<AppUserVM>(context);
            SearchPost _searchPost = SearchPost();
            print("builder");
            return AlertDialog(
              title: const Text("Advert"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: normalTextStyle,
                        onChanged: (value) {
                          _searchPost.title = value;
                        },
                        decoration: loginInputStyle.copyWith(
                          hintText: 'Email',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _postVM.searchPost = SearchPost();
                    Navigator.pop(context);
                    _appUserVM.tec.text = _postVM.searchPost.toString();
                  },
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _postVM.searchPost = _searchPost;
                    _appUserVM.tec.text = _postVM.searchPost.toString();
                    Navigator.pop(context);
                    // TODO search call
                  },
                  child: const Text("Search"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
