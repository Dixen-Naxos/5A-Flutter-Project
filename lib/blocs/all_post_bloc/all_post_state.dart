part of 'all_post_bloc.dart';

enum AllPostStatus {
  initial,
  loading,
  success,
  error,
}

class AllPostState {
  final ListPosts? posts;
  final AllPostStatus status;
  final bool scrollLoading;

  const AllPostState({
    this.posts,
    this.status = AllPostStatus.initial,
    this.scrollLoading = false,
  });

  AllPostState lockScrollLoading() {
    return AllPostState(
      posts: posts,
      status: status,
      scrollLoading: true,
    );
  }

  AllPostState copyWith({
    ListPosts? posts,
    AllPostStatus? status,
  }) {
    return AllPostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  AllPostState addPosts({
    ListPosts? posts,
    AllPostStatus? status,
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

    return AllPostState(
      posts: newList,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  AllPostState removePosts({
    required Post post,
    AllPostStatus? status,
  }) {
    posts!.items.remove(post);
    return AllPostState(
      posts: posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  AllPostState patchPosts({
    required Post post,
    AllPostStatus? status,
  }) {
    for (int i = 0; i < posts!.items.length; i++) {
      if (posts!.items[i].id == post.id) {
        post.author = posts!.items[i].author;
        post.commentCounts = posts!.items[i].commentCounts;
        posts!.items[i] = post;
        break;
      }
    }
    return AllPostState(
      posts: posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  AllPostState deleteCommentFromPost({
    required Post post,
    AllPostStatus? status,
  }) {
    for (int i = 0; i < posts!.items.length; i++) {
      if (posts!.items[i].id == post.id) {
        posts!.items[i].commentCounts = posts!.items[i].commentCounts! - 1;
        break;
      }
    }
    return AllPostState(
      posts: posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }

  AllPostState createCommentFromPost({
    required Post post,
    AllPostStatus? status,
  }) {
    for (int i = 0; i < posts!.items.length; i++) {
      if (posts!.items[i].id == post.id) {
        posts!.items[i].commentCounts = posts!.items[i].commentCounts! + 1;
        break;
      }
    }
    return AllPostState(
      posts: posts,
      status: status ?? this.status,
      scrollLoading: false,
    );
  }
}
