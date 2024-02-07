part of 'user_post_bloc.dart';

enum UserPostStatus {
  initial,
  loading,
  success,
  error,
}

class UserPostState {
  final ListPosts? posts;
  final UserPostStatus status;
  final bool scrollLoading;

  const UserPostState({
    this.posts,
    this.status = UserPostStatus.initial,
    this.scrollLoading = false,
  });

  UserPostState lockScrollLoading() {
    return UserPostState(
      posts: posts,
      status: status,
      scrollLoading: true,
    );
  }

  UserPostState copyWith({
    ListPosts? posts,
    UserPostStatus? status,
  }) {
    return UserPostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  UserPostState addPosts({
    ListPosts? posts,
    UserPostStatus? status,
  }) {
    ListPosts newList = ListPosts(
      itemsReceived: posts!.itemsReceived,
      curPage: posts.curPage,
      nextPage: posts.nextPage,
      prevPage: posts.prevPage,
      offset: posts.offset,
      itemsTotal: posts.itemsTotal,
      pageTotal: posts.pageTotal,
      items: this.posts!.items..addAll(posts.items),
    );

    return UserPostState(
      posts: newList,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  UserPostState removePosts({
    required Post post,
    UserPostStatus? status,
  }) {
    posts!.items.remove(post);
    return UserPostState(
      posts: posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }
}
