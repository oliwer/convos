<user-login>
  <div class="row">
    <form onsubmit={submitForm} class="col s10 offset-s1 m6 offset-m3 z-depth-1">
      <div class="row">
        <div class="col s12">
          <h2 class="teal-text darken-4">Convos</h2>
          <p><i>- Collaberation done right.</i></p>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input placeholder="susan@example.com" name="email" id="form_email" type="email" class="tooltipped validate">
          <label for="form_email">Email</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input placeholder="At least six characters" name="password" id="form_password" type="password" class="tooltipped validate">
          <label for="form_password">Password</label>
        </div>
      </div>
      <div class="row" if={formError}>
        <div class="col s12"><div class="alert">{formError}</div></div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <button class="btn waves-effect waves-light" type="submit" name="action">
            Log in
            <i class="mdi-content-send right"></i>
          </button>
          <a href="#register" class="btn-flat waves-effect waves-light">Register</a>
        </div>
      </div>
    </form>
    <div class="col s10 offset-s1 m6 offset-m3 about">
      &copy; <a href="http://nordaaker.com">Nordaaker</a> - <a href="http://convos.by">About</a>
    </div>
  </div>

  mixin.form(this);
  mixin.http(this);

  submitForm(e) {
    e.preventDefault();
    this.formError = ''; // clear error on post
    localStorage.setItem('email', this.form_email.value);
    this.httpPost(
      apiUrl('/user/authenticate'),
      {email: this.form_email.value, password: this.form_password.value},
      function(err, xhr) {
        if (!err) convos.save(xhr.responseJSON);
        this.httpInvalidInput(xhr.responseJSON);
        convos.render(this);
      }
    );
  }

  this.on('mount', function() {
    if (convos.email()) return Router.route('chat');
    this.form_email.value = localStorage.getItem('email');
    this.form_email.focus();
  });
</user-login>
